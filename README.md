# R Methods book 

## Install Quarto and packages

### Install Quarto

First, [install Quarto](https://quarto.org/docs/get-started/). I'll assume you're using RStudio (otherwise let me know and I'll add instructions)

### Open the R-canon project

Open the R-canon project in RStudio (as an actual R project, not just as a working directory)

### Manage packages

To manage packages we use the `renv` packages. This lets us create a snapshot of all the packages and versions used in this project, and recreate the environment on another machine.
Simply put, it maintains a `renv.lock` file (in the project directory) that lists all the packages and their versions used in the project. 

How to mainly use this:

- When you cloned the repo or pulled changed from GitHub, run 
  `renv::restore()` to install the packages and versions defined in the `renv.lock` file on your device.
- When you added new packages in a tutorial, run `renv::snapshot()` to update the `renv.lock` file.
- Every now an then, we should run `renv::update()` to update all the packages in `renv.lock` to their latest versions.
- Run `renv::status()` whenever you like to see if things are up to date.


## Development

Open any Quarto file in the project. You should then see the Render button (ctrl + shift + K) in the toolbar of RStudio. This will now automatically render the entire book.
If you make changes to a chapter, run this again to see the changes in the preview.

If the render is successfull, you've actually updated the book already. If you push it to GitHub, the website will automatically be updated.

### Adding tutorials

Notice that the directory names match the sections of the book (e.g. data-management, analysis). Inside these directories you see:

- An index.qmd file.
- The .qmd files for the tutorials, or directories for subsections.


The index.qmd file is the main file for the section, and it will be rendered as the main page of the section.
Also notice that the YAML at the top specifies the *title* and *order*. e.g. see analysis/index.qmd.

```
---
title: Analysis
order: 3
---

Here we could add the main page for the analysis section. 
(empty at the time of writing)
```

The *title* setting is obvious. The *order* setting determines where in the order of sections the Analysis section is placed. 
At the time of writing this is the third section (after `Getting Started` and `Data management`).

#### TLDR

To add a new tutorial, simply create a new .qmd file in the appropriate directory, and at a YAML at the top that specifies the title and order.
To add a new (sub)section, create a new directory, and add an index.qmd file with the title and order.



