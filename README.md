# Score reports for the Oregon Extended Assessment
This repo has all the files to build the individual student score reports for the Oregon Extended Assessment. The score reports are built using R with the [pagedown](https://github.com/rstudio/pagedown) package; the plot within the score report is made with [ggplot2](https://ggplot2.tidyverse.org/). The pagedown report is parameterized, with a shell script used to change the report parameters. The whole thing is packaged into a [docker](https://www.docker.com/) container, which then is (will be) incorporated into the production code.

## Example score report

![Screen Shot 2021-09-28 at 4 30 52 PM](https://user-images.githubusercontent.com/10944136/135179215-092ee2aa-5471-403c-a0e0-7240665f11e9.png)


# Process for building the docker file and experimenting with the API
If you'd like to get a full picture of how this all works, feel free to clone the repo and build the docker image locally. To do this, first make sure you have [docker installed](https://www.docker.com/get-started). Then do the following

1. Launch Docker (make sure it's running)
2. Open terminal on your local machine (`/Applications/Utilities/Terminal.app` if on a mac)
3. Type `cd ` and then drag the folder to terminal. Make sure there is a space between `cd` and the path. Hit enter. You should see the terminal prompt change to show that you are now in that folder.
5. Type `docker build -t orext-score-report .` into the terminal and hit enter. This will build the docker image and may take a few minutes the first time (it's fast thereafter because of caching).
6. Open the `params.txt` file. This is all the parameters for the score report. Edit them however you'd like.

## Rendering
There are two shell scripts in the image, one for rendering the score report (to html) and one for converting the html to PDF. To create one HTML report, with the parameters in `params.txt`, run the following in terminal

```sh
cat params.txt | docker run -i orext-score-report render.sh > new.html
```

The first part of this (before `|`) reads in the `params.txt` file. This then gets passed to the docker image. We are asking to run the `orext-score-report` image interactively `-i`, and pass the contents of `params.txt` to `render.sh`. This script then renders the HTML, and the result will be saved in `new.html` (or whatever you want to call it.)

After rendering to HTML, we might also want to have a PDF copy. We can do this by running

```sh
cat new.html | docker run -i orext-score-report convert-pdf.sh > new.pdf
```

This time we're passing the `new.html` file that we rendered from the previous run to the `convert-pdf` script, which will then be saved in `new.pdf` (or whatever you want to call it).

## Big picture
This is all meant to be done programmatically. Initially, I had built this image with a [plumber](https://www.rplumber.io/) API, but I think this is better because it can work directly with the database. In other words, we shouldn't have to host the web API through AWS or some similar service. Instead, we just programmatically create the `params.txt` files from the database and pass them to the docker image, as above.

# Notice anything wrong?
If you do happen to play with it and you identify any problems, please [file an issue](https://github.com/UO-BRT/orext-score-reports/issues) describing the problem in as much detail as possible.

