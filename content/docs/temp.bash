#!/bin/bash

# First, remove the old 02_computers-and-programming directory
rm -rf 02_computers-and-programming

# Rename all directories to sequential numbers
mv 02a-hipergator 02_hipergator
mv 02b-git-github 03_git-github  
mv 02c-command-line 04_command-line
mv 02d-r-python 05_r-python
mv 02e-workflow-managers 06_workflow-managers
mv 02f-build-deploy-web-apps 07_build-deploy-web-apps
mv 03_our-tools 08_our-tools
mv 04_experimental-design 09_experimental-design
mv 05_analysis-pipelines 10_analysis-pipelines
mv 06_downstream-analysis 11_downstream-analysis
mv 07_visualization 12_visualization
mv 08_data-sharing 13_data-sharing
mv 09_grant-writing 14_grant-writing
mv 10_publishing 15_publishing
mv 11_webapps 16_webapps
mv 12_presentations 17_presentations
mv 13_communications 18_communications
mv 14_blog 19_blog
mv 15_miscellaneous 20_miscellaneous

# Update weights in all _index.md files
sed -i '' 's/weight: [0-9]*/weight: 2/' 02_hipergator/_index.md
sed -i '' 's/weight: [0-9]*/weight: 3/' 03_git-github/_index.md
sed -i '' 's/weight: [0-9]*/weight: 4/' 04_command-line/_index.md
sed -i '' 's/weight: [0-9]*/weight: 5/' 05_r-python/_index.md
sed -i '' 's/weight: [0-9]*/weight: 6/' 06_workflow-managers/_index.md
sed -i '' 's/weight: [0-9]*/weight: 7/' 07_build-deploy-web-apps/_index.md
sed -i '' 's/weight: [0-9]*/weight: 8/' 08_our-tools/_index.md
sed -i '' 's/weight: [0-9]*/weight: 9/' 09_experimental-design/_index.md
sed -i '' 's/weight: [0-9]*/weight: 10/' 10_analysis-pipelines/_index.md
sed -i '' 's/weight: [0-9]*/weight: 11/' 11_downstream-analysis/_index.md
sed -i '' 's/weight: [0-9]*/weight: 12/' 12_visualization/_index.md
sed -i '' 's/weight: [0-9]*/weight: 13/' 13_data-sharing/_index.md
sed -i '' 's/weight: [0-9]*/weight: 14/' 14_grant-writing/_index.md
sed -i '' 's/weight: [0-9]*/weight: 15/' 15_publishing/_index.md
sed -i '' 's/weight: [0-9]*/weight: 16/' 16_webapps/_index.md
sed -i '' 's/weight: [0-9]*/weight: 17/' 17_presentations/_index.md
sed -i '' 's/weight: [0-9]*/weight: 18/' 18_communications/_index.md
sed -i '' 's/weight: [0-9]*/weight: 19/' 19_blog/_index.md
sed -i '' 's/weight: [0-9]*/weight: 20/' 20_miscellaneous/_index.md

echo "All directories renumbered and weights updated!"
