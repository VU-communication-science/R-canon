# R Methods book 

## Book link

[dataliteracy.cc](https://dataliteracy.cc)


## Setting things up

### Install Quarto

First, [install Quarto](https://quarto.org/docs/get-started/). I'll assume you're using RStudio (otherwise let me know and I'll add instructions)

### Install Git

Install [Git](https://git-scm.com/downloads).

### Clone the GitHub repo

You can directly use Git from within R.
Go to File -> New Project -> Version control -> Git.
Use the repository URL: https://github.com/VU-communication-science/R-canon

This copies the repository to the designated folder on your device, and opens
it as an R project. 

### Install packages

To build the book, you'll need to have installed all the R packages
used in any of the chapters. To make this easier, we created the
`install_dependencies.R` script.


## Updating the book

Updating the book takes 2 steps:

* Make changes and render the new version of the book
* Push the changes to GitHub

The website will automatically be updated.
Note that it might take a few minutes after pushing for the change to show up on the website.


### Rendering the book

Open any Quarto file in the project. You should then see the Render button (ctrl + shift + K) in the toolbar of RStudio. This will now automatically render the entire book.
This will take some time the first time, but after that it will only need
to re-render the specific Quarto files that you update.

### Pushing changes to GitHub

In your Environment pane in RStudio, you should see a **Git** tab. If you open this you
see a list of all the files that you edited. Note that this can be more files that you
manually edited. Specifically, when you render the book, it will automatically edit many
files in the `docs` folder. 

To update the website, you will need to submit ALL these changes to GitHub. 
The easiest procedure is:

* Click on the **Commit** button. This opens a new window which shows all the edited
files at the top, and you can also see the specific changes per file.
* **Stage** ALL the files. So all the files in the list need to have a checkmark. Note that you
can select a range of file by holding *shift* when you click on the file names, and then stage
them all at once with the **stage** button.
* Write a **Commit** message. This can just be a single sentence describing what you did (e.g. "Updated ANOVA tutorial")
* Close the pop-up window when ready. You should now see a sentence saying something like "Your branch is ahead of 'origin/main' by 1 commit".
* To push this commit to GitHub, click the **Push** button. (The first time you might have to login to GitHub first)

### Pulling changes from GitHub

Every time you start working on the book, make sure to **Pull** any recent
changes from GitHub first. 

Someone else (or you on a different device) might have updated the book,
so if you don't get the most recent version, you might be working in an older
version of the book. If so, you'll get an error when trying to push your changes:

"Updates were rejected because the remote contains work that you do not
hint: have locally""

You will then need to **Pull** the most recent version, and pray that your updates
do not overlap with those of the earlier commit.
To pull the changes, click the **Pull** button (you might need to use the one in your main RStudio window, not the one from the Commit pop-up)

Note that you will likely get a lot of conflicts on the files on the
`docs/` directory. This directory contains the files
that are automatically generated when rendering the website. 
To resolve the conflicts, you can just delete the `docs/` directory
and re-render the book (which creates it anew).

Merge conflicts can be a pain, so just let me know if you run into any issues. 
Remember that there's also always the nuclear option: make a copy of the tutorials that you updated,
and then just delete the entire project, clone it again from GitHub, and paste in your changes.

## About the structure of the book

Notice that the directory names match the sections of the book (e.g. data-management, analysis). Inside these directories you see:

- An index.qmd file.
- The .qmd files for the tutorials, or directories for subsections.

The index.qmd file is the main file for the section, and it will be rendered as the main page of the section.
Also notice that the YAML at the top specifies the **title** and **order**. e.g. see analysis/index.qmd.

```
---
title: Analysis
order: 3
---

Here we could add the main page for the analysis section. 
(empty at the time of writing)
```

The **title** setting is obvious. The **order** setting determines where in the order of sections the Analysis section is placed. 
At the time of writing this is the third section (after `Getting Started` and `Data management`).

#### TLDR

To add a new tutorial, simply create a new .qmd file in the appropriate directory, and at a YAML at the top that specifies the title and order.
To add a new (sub)section, create a new directory, and add an index.qmd file with the title and order.



