# Score reports for the Oregon Extended Assessment
This repo has all the files to build the individual student score reports for the Oregon Extended Assessment. The score reports are built using R with the [pagedown](https://github.com/rstudio/pagedown) package; the plot within the score report is made with [ggplot2](https://ggplot2.tidyverse.org/). The pagedown report is parameterized, and is rendered via a [plumber](https://www.rplumber.io/) API. The whole thing is packaged into a [docker](https://www.docker.com/) container, which then is (will be) incorporated into the production code.

## Example score report
![Screen Shot 2021-09-28 at 1 36 29 PM](https://user-images.githubusercontent.com/10944136/135161825-12a8b8ef-3b93-4a4e-b4a3-efd035a697df.png)

# Process for building the docker file and experimenting with the API
If you'd like to get a full picture of how this all works, feel free to clone the repo and build the docker image locally. To do this, first make sure you have [docker installed](https://www.docker.com/get-started). Then do the following

1. Launch Docker (make sure it's running)
3. Open terminal on your local machine (`/Applications/Utilities/Terminal.app` if on a mac)
4. Type `cd ` and then drag the folder to terminal. Make sure there is a space between `cd` and the path. Hit enter. You should see the terminal prompt change to show that you are now in that folder.
5. Type `docker build -t orext-score-report .` into the terminal and hit enter. This will build the docker image and may take a few moments the first time.
6. Once the above is done, type `docker run --rm -p 80:80 orext-score-report`. If you get an error, try `docker run --rm -p 81:80 orext-score-report`. 
7. Go to the following link in your web browser

http://127.0.0.1/report?ssid=5567&year=2015-16&name=Susan%20B.%20Anthony&content=ELA&birth_date=06%2F15%2F00&grade=3&test_date=06%2F12%2F16&teacher_name=Janice%20Pembrook&schid=1208&sch_name=Super%20Star%20Elementary&distid=31078&dist_name=Amazing%20District&countyid=128&county_name=Dry%20Flats&score=225

Or if you had to change it to run on `81:80`, try

http://127.0.0.1:81/report?ssid=5567&year=2015-16&name=Susan%20B.%20Anthony&content=ELA&birth_date=06%2F15%2F00&grade=3&test_date=06%2F12%2F16&teacher_name=Janice%20Pembrook&schid=1208&sch_name=Super%20Star%20Elementary&distid=31078&dist_name=Amazing%20District&countyid=128&county_name=Dry%20Flats&score=225

8. In the address above, you may notice that all the arguments to the parameterized report are in the address. Change any of these in the web browser and the report will re-generate with the new arguments (e.g., change `score=225` to `score=200`; you should see the point on the line change as well as the performance level that is highlighted).


# Notice anything wrong?
If you do happen to play with it and you identify any problems, please [file an issue](https://github.com/UO-BRT/orext-score-reports/issues) describing the problem in as much detail as possible.

