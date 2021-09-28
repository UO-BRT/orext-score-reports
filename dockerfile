FROM rocker/r-ver:4.1.1

RUN /bin/sh -c /rocker_scripts/install_pandoc.sh # buildkit

RUN apt-get update -qq && apt-get install -y \
      libssl-dev \
      libcurl4-gnutls-dev

RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_version('plumber', version = '1.0.0')"
RUN R -e "remotes::install_version('pagedown', version = '0.15')"
RUN R -e "remotes::install_version('ggplot2', version = '3.3.5')"

COPY api-run.R api-setup.R oregon.png score-report-style.css score-report.Rmd /

EXPOSE 80

ENTRYPOINT ["Rscript", "api-run.R"]