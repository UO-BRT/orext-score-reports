#! /usr/bin/env Rscript

sin <- file("stdin")
params_in <- readLines(sin)
close(sin)

splt <- strsplit(params_in, ": ?")

varnames <- vapply(splt, `[`, 1, FUN.VALUE = character(1))
param_args <- lapply(splt, `[`, 2)
names(param_args) <- varnames


rmarkdown::render(
  "score-report.Rmd",
  output_file = "out.html",
  params = list(
    ssid = as.numeric(param_args$ssid),
    year = param_args$year,
    name = param_args$name,
    grade = as.numeric(param_args$grade),
    content = param_args$content,
    birthdate = param_args$birthdate,
    testdate = param_args$testdate,
    assessor = param_args$assessor,
    school_id = param_args$school_id,
    school_name = param_args$school_name,
    district_id = param_args$district_id,
    district_name = param_args$district_name,
    county_name = param_args$county_name,
    score = as.numeric(param_args$score)
  ),
  quiet = TRUE
)

html <- readBin("out.html", "raw", n = file.size("out.html"))
con <- pipe("cat", "wb")
writeBin(html, con)
flush(con)
close(con)
