#! /usr/bin/env Rscript
sin <- file("stdin")
writeLines(readLines(sin), "html_in.html")
close(sin)

pagedown::chrome_print("html_in.html", extra_args = "--no-sandbox")

pdf <- readBin("html_in.pdf", "raw", file.size("html_in.pdf"))

con <- pipe("cat", "wb")
writeBin(pdf, con)
flush(con)
close(con)