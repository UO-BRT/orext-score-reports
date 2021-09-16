FROM rocker/r-ver:4.1.1

RUN /bin/sh -c /rocker_scripts/install_pandoc.sh # buildkit

RUN apt-get update -qq && apt-get install -y \
      libssl-dev \
      libcurl4-gnutls-dev

RUN R -e "install.packages(c('plumber', 'pagedown', 'ggplot2'))"

COPY api-run.R api-setup.R oregon.png score-report-style.css score-report.Rmd /

EXPOSE 80

ENTRYPOINT ["Rscript", "api-run.R"]