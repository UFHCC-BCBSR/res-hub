Modified on: \(Mon, Aug 23, 2021 at 10:20 AM\)  

---  

\#\# \*\*Summary\*\*  

1\. \*\*Keep file names short and relevant.\*\*  

2\. \*\*Avoid using spaces, underscores, or periods between words. Instead, use hyphens between words.\*\*  

3\. \*\*Avoid use of uppercase characters.\*\*  
   Use lower case characters, even if the file name is a proper noun or name.  

4\. \*\*Do not use non‑alphanumeric characters.\*\*  
   Replace characters such as:\ `:_ \\ / \< \> | "` ? \[ \] ; = + & £ $ ,` with hyphens or an equivalent word,\ e.g., replace `&` with `and`.  

5\. \*\*Avoid using unconventional abbreviations or acronyms.\*\*  
   e.g. student‑outreach‑resource‑center is better than SOURCE.  

6\. \*\*Always include the file extension at the end of documents and image filenames.\*\*  
   It is very important that files end in their respective file format, e.g., .R, .bash, .txt.  

7\. \*\*Write dates back to front.\*\*  
   If using a date in the file name, always state the date 'back to front', and use four‑digit years, two‑digit months, and two‑digit days: `YYYY-MM-DD` or `YYYY-MM` or `YYYY` or `YYYY-YYYY.`  
   \* 2004-03-24-agenda.doc  

8\. \*\*Use version numbers.\*\*  
   If you need to indicate the version number of a file in its name, this should be indicated in its file name by the inclusion of `v` followed by the version number. Use two‑digit numbers unless it is a year or another number with more than two digits.  
   \* run-script‑v01.doc  
   \* run-script‑v02.doc  
   \* run-script‑v03.doc  
   \* run-script‑v04.doc  

9\. \*\*Last Name, First Name.\*\*  
    When including a personal name in a filename, state the last name first followed by the first name.  

```\`\`bash  
* kates-heather-output.RData  
\`\`\`  

---  

\#\# \*\*Detailed\*\*  

\#\#\# 1\. \*\*Keep file names short and relevant.\*\*  
File names should be kept as short as possible while also being meaningful. Long file names mean long file paths, which increase the likelihood of error and are more difficult to remember and recognize.  

However, avoid using initials, abbreviations, and codes that are not commonly understood. This is particularly important for records that have to be kept for a long period of time, as the meaning of the acronym may not be known over time.  

\*\*Incorrect\*\*  
\*\*Correct\*\*  

Description\_of\_How\_to\_use\_HiPerGator.doc  
hipergator-how-to.doc  

\*\*Explanation\*\*  
Some words, like ‘the’ and ‘and’, add length to a file name but do not contribute towards the meaning. If the remaining file name remains meaningful within the context of the file directory, these elements can be removed.  

---  

\#\#\# 2\. \*\*Avoid using spaces, underscores, or periods between words.\*\*  
Some applications and computer scripts may not recognize spaces or will process files differently when they include spaces, underscores, or periods. Spaces are replaced with `%20` when encountered in a file name on a web server; spaces are not supported characters in URLs.  

For example “How to name files.pdf” becomes “how%20to%20name%20files.pdf”.  

Spaces, underscores, or periods should be replaced with hyphens (-) except when indicating the file extension type (e.g., .doc, .pdf, .ppt, etc.)  

\*\*Incorrect\*\*  
What is HiPerGator.doc  
What\_is\_HiPerGator.pdf  
What.is.HiPerGator.ppt  

\*\*Correct\*\*  
what-is-hipergator.doc  
what-is-hipergator.pdf  
what-is-hipergator.ppt  

\*\*Explanation\*\*  
Replacing spaces, underscores, and periods with hyphens (`-`) will ensure files and URLs still work properly and increase legibility.  

---  

\#\#\# 3\. \*\*Avoid use of uppercase characters.\*\*  
To keep filenames consistent, use lowercase characters for all filenames.  

\*\*Incorrect\*\*  
WHATISHIPERGATOR.doc  
WhatIsHiPerGator.pdf  

\*\*Correct\*\*  
what-is-hipergator.doc  
what-is-hipergator.pdf  

\*\*Explanation\*\*  
In this example, by changing the capitalized letters to all lowercase and adding hyphens (`-`) between each word, each filename becomes easier to read and presents a consistent look.  

---  

\#\#\# 4\. \*\*Do not use non‑alphanumeric characters.\*\*  
Non‑alphanumeric characters are not supported or recognized within a URL string and may carry special meaning.  

**Incorrect**  
Smith,John20070507.txt  
"DavidLaingCollection".doc  
Guidelines&Regulations.pdf  
Budget2006/07.xls  

**Correct**  
2007-05-07-smith-john.txt  
david-laing-collection.doc  
guidelines-and-regulations.pdf  
2006-2007-budget.xls  

**Explanation**  
Most non‑alphanumeric characters can be omitted or replaced with alphanumeric characters; hyphens (`-`) can replace slashes and brackets.  

---  

\#\#\# 5\. \*\*Avoid using unconventional abbreviations and acronyms.\*\*  
Avoid initials, abbreviations, acronyms, and codes that are not commonly understood.  

**Incorrect**  
SOURCEoverview.doc  

**Correct**  
student-outreach-resource-center-overview.doc  

**Explanation**  
Spelling out the acronym provides clarity, especially for users unfamiliar with the center.  

---  

\#\#\# 6\. \*\*Always include the file extension at the end of documents and image filenames.\*\*  

**Incorrect**  
overview-of-malaria  
microscope-of-malaria  
malaria-presentation  
malaria-research  

**Correct**  
overview-of-malaria.doc  
microscope-of-malaria.jpg  
malaria-presentation.ppt  
malaria-research.xlsx  

**Explanation**  
Without file extensions, it is difficult to identify file types.  

---  

\#\#\# 7\. \*\*Write dates back to front.\*\*  

**Incorrect**  
1Feb2005Agenda.doc  
1Feb2005Minutes.doc  
24March2004Agenda.doc  

**Correct**  
2004-03-24-agenda.doc  
2004-03-24-minutes.doc  
2004-03-24-paper-a.doc  

**Explanation**  
Chronological order is preserved when dates are written `YYYY-MM-DD`.  

---  

\#\#\# 8\. \*\*Use version numbers.\*\*  

**Incorrect**  
event_announcement_1.doc  
event_announcement_2.doc  
event_announcement_3.doc  

**Correct**  
event-announcement-v01.doc  
event-announcement-v02.doc  
event-announcement-v03.doc  
event-announcement-v04.doc  

**Explanation**  
Version numbers distinguish drafts; avoid temporary labels like `draft` or `final`.  

---  

\#\#\# 9\. \*\*Include the stock photo ID number at the end of images.\*\*  

**Incorrect**  
antitobaccosign.jpg  

**Correct**  
anti-tobacco-sign-884732552.jpg  

**Explanation**  
Including the stock ID makes it easier to identify the source.  

---  

\#\#\# 10\. \*\*Last Name, First Name.\*\*  

**Incorrect**  
EllenJMacKenzieheadshot.jpg  

**Correct**  
mackenzie-ellen-j-headshot.jpg  

**Explanation**  
Files are sorted by last name, making search more intuitive.  

---  

\*Credit\*  
The original content is adapted from the *Image \& File Naming Conventions* page on the JHU BSPH Website Help Desk: https://webhelp.publichealth.jhu.edu/support/solutions/articles/6000251494-image-file-naming-conventions.  
