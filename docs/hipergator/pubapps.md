# UFRC PubApps: Deploying Shiny Apps with Podman

## Overview

UFRC PubApps is a virtual machine managed by UF Research Computing that allows
us to host containerized web applications accessible via public URLs. We use
[Podman](https://podman.io/) (a daemonless, rootless alternative to Docker) to
build and run containers on this VM. All of our currently deployed apps are R
Shiny apps, though the same workflow applies to other app types with some
differences noted below.

---

## Signing In

PubApps is only accessible by SSHing from HiPerGator. You cannot SSH in directly
from your local machine. Everyone logs in as PubApps user jobrant, but access is managed through your hipergator account.

```bash
ssh jobrant@pubjobrant1
```

If you are prompted for a password, it is not working — access is by SSH key
only. If you cannot connect, you need to be added as an authorized user (see
[Adding a New User](#adding-a-new-user)).

---

## Directory Structure

The top-level structure on the VM looks like this:

```
~/
├── bcb-sr/
│   ├── prod/
│   │   ├── apps/            # Production app code (bind-mounted at runtime)
│   │   └── web/
│   │       └── index.html   # Production landing page
│   ├── dev/
│   │   ├── apps/            # Development app code (bind-mounted at runtime)
│   │   └── web/
│   │       └── index.html   # Dev landing page
│   └── tests/
├── Dockerfiles/             # Archived/misc Dockerfiles not in active deployment
├── port_info.csv            # Record of all port assignments and URLs
└── README.md
```

When starting a new app, create its directories manually or via git clone (see
[Code Development Workflow](#code-development-workflow)). :

```bash
mkdir -p ~/bcb-sr/prod/apps/<your-app-name>
mkdir -p ~/bcb-sr/dev/apps/<your-app-name>
```

Production-ready code goes in `prod/apps/`, work-in-progress in `dev/apps/`.
The web index pages (`web/index.html`) are where the landing pages listing
available apps are maintained — update these when adding a new app with a live URL.

(This directory schema is just for organizational purposes and does not affect the running containers or URLs; any container can bind-mount any filepath and any port can be mapped to any URL.)

---

## Code Development Workflow

**Avoid writing or editing code directly on the PubApps VM.** The VM has no UI and
is not set up as a development environment. The best workflow is:

1. Develop and test your app on HiPerGator and/or locally
2. Push changes to GitHub
3. On the VM, clone the repo once into the appropriate `apps/` directory:

```bash
cd ~/bcb-sr/prod/apps/
git clone <your-repo-url> <your-app-name>
```

4. For subsequent updates, pull changes:

```bash
cd ~/bcb-sr/prod/apps/<your-app-name>
git pull origin main
```

The VM is a deployment target only. All development should happen elsewhere.

---

## Building a Container Image with Podman

### The Dockerfile

Each app needs a Dockerfile that defines its environment. Below is a minimal
starting point for an R Shiny app — **only include the packages your app
actually needs.** Adding unnecessary packages increases image size and build
time, and makes the environment harder to maintain.

```dockerfile
# Use the official Rocker Shiny base image
FROM rocker/shiny:latest

# Install system dependencies
# These are common ones — remove any your app does not need
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install only the CRAN packages your app actually uses
RUN install2.r --error \
    shiny \
    <package1> \
    <package2>

# If your app uses Bioconductor packages, install BiocManager first,
# then only the packages you need
RUN R -e "install.packages('BiocManager', repos='https://cran.rstudio.com/')"
RUN R -e "BiocManager::install(c('<BiocPackage1>', '<BiocPackage2>'), update = FALSE)"

# Expose the Shiny port
EXPOSE 3838

# Start the Shiny app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]
```

> **Best practice**: Think of the image as the *environment*, not the *app*.
> It should contain R, system libraries, and R packages — nothing else. In most cases, app
> code can just be bind-mounted at runtime (see below), which means you can update the
> app without rebuilding the image.

#### Image size and storage

Image size is determined entirely at build time by what you install. A common
source of unexpectedly large images is installing packages "just in case" rather
than only what the app requires. Once built, the image itself does not grow.
However, if a running container writes files to paths inside the container that
are not bind-mounted to the host, those writes accumulate in the container's
writable layer. Any files your app generates at runtime (e.g. user uploads,
temporary outputs) should be written to `/tmp` inside the container, or to a
bind-mounted directory on the host.

#### Non-Shiny apps

The same Podman workflow applies to non-Shiny apps (e.g. Python/Flask, FastAPI,
Streamlit). The main differences are the base image (`python:3.x-slim` or
similar instead of `rocker/shiny`), the internal port (varies by framework),
and the `CMD`. The port mapping and deployment steps are otherwise identical.

### Building the image

Run this from the directory containing your Dockerfile:

```bash
podman build -t <image-name>:latest .
```

You can also specify a Dockerfile by name if it is not called `Dockerfile`:

```bash
podman build -t <image-name>:latest -f <Dockerfile-name> .
```

Use a clear, consistent image name (e.g. `myapp-prod`, `batchcorrector`).
You will reference it by name when running containers.

### Inspecting images

```bash
# List all local images
podman images

# Inspect a specific image
podman inspect <image-name>
```

---

## Running Containers

### Port assignment: "prod is odd"

Each app gets two ports — one for production, one for dev. **Odd ports map to
production (`bcb-sr.rc.ufl.edu`) and even ports map to dev
(`devbcb-sr.rc.ufl.edu`).** Ports are assigned in sequence. To find the next
available pair:

1. Check `port_info.csv` for the highest assigned port
2. Also run `podman ps` to catch any running containers not yet recorded
3. Take the next odd number as your prod port and the following even number as dev

> Note: a container could be stopped and not appear in `podman ps` but still
> have its port recorded in `port_info.csv` — check both.

### Running a container

```bash
podman run -d \
  --name <container-name> \
  -p <PORT>:3838 \
  -v /pubapps/jobrant/bcb-sr/prod/apps/<your-app-name>:/srv/shiny-server \
  localhost/<image-name>:latest
```

The `-v` flag bind-mounts your app code directory into the container at the
path Shiny expects. This means you can update the app by doing `git pull` and
restarting the container without rebuilding the image, and the image stays lean
and reusable across app versions.

**Alternatively**, you can bake the code into the image using a `COPY`
instruction in the Dockerfile. This makes the image self-contained and
portable, but means you must rebuild and redeploy the image every time the
app code changes. For active development, the bind-mount approach is strongly
preferred.

#### The --replace flag

If a container with that name already exists, add `--replace` to stop and
replace it in one command:

```bash
podman run -d --replace \
  --name <container-name> \
  -p <PORT>:3838 \
  -v /pubapps/jobrant/bcb-sr/prod/apps/<your-app-name>:/srv/shiny-server \
  localhost/<image-name>:latest
```

---

## Managing Running Containers

```bash
# List all running containers
podman ps

# List all containers including stopped ones
podman ps -a

# Stop a container
podman stop <container-name>

# Start a stopped container
podman start <container-name>

# Restart a container
podman restart <container-name>

# View logs (useful for debugging)
podman logs <container-name>
podman logs --tail 50 <container-name>
```

### Checking storage and pruning

Unused images and stopped containers accumulate and consume disk space. Clean
up periodically:

```bash
# Check disk usage by images, containers, and volumes
podman system df

# Remove all stopped containers
podman container prune

# Remove all unused images (not referenced by any container)
podman image prune

# Remove everything unused at once (containers, images, volumes)
podman system prune
```

> **Caution**: `podman system prune` will remove stopped containers and unused
> images. Make sure you do not need them before running it — images take time
> to rebuild.

---

## Requesting a URL (Reverse Proxy)

Once your containers are running, submit a ticket to UFRC to assign URLs:

**URL**: https://support.rc.ufl.edu/enter_bug.cgi

Use this template:

```
Subject: URL assignment for jobrant@pubjobrant1

Hello,

Can you please assign the following URLs:

<PROD PORT> -> https://bcb-sr.rc.ufl.edu/<your-app-name>
<DEV PORT>  -> https://devbcb-sr.rc.ufl.edu/<your-app-name>

Thank you!
```

You can test that the container is responding before submitting the ticket:

```bash
curl http://localhost:<PORT>
```

---

## Updating port_info.csv

Every deployed container must be recorded in `port_info.csv`. Add a row for
each container (prod and dev) with all fields populated:

```
port,container,volume,image,URL
21123,myapp-prod,/pubapps/jobrant/bcb-sr/prod/apps/myapp:/srv/shiny-server,localhost/myapp:latest,https://bcb-sr.rc.ufl.edu/myapp/
21124,myapp-dev,/pubapps/jobrant/bcb-sr/dev/apps/myapp:/srv/shiny-server,localhost/myapp:latest,https://devbcb-sr.rc.ufl.edu/myapp/
```

This file is the authoritative record of what is deployed and where. Keep it
up to date — it is the first place to check when troubleshooting or adding a
new app.

---

## Adding a New User

To give a HiPerGator user SSH access to the PubApps VM:

1. Ask them to share their public SSH key from their `~/.ssh/` directory on HiPerGator
2. Append that key to `~/.ssh/authorized_keys` on `pubjobrant1`:

```bash
echo "<their public key>" >> ~/.ssh/authorized_keys
```

They can then SSH in from HiPerGator. If they are prompted for a password,
the key was not added correctly.

---

