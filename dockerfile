FROM rhub/r-minimal

# install rmarkdown and ggplot2
RUN installr -d rmarkdown 
RUN installr -d -t gfortran ggplot2

# install pagedown
RUN apk add --no-cache --update-cache \
      --repository http://nl.alpinelinux.org/alpine/v3.11/main \
      autoconf=2.69-r2 \
      automake=1.16.1-r0 && \
      # repeat autoconf and automake (under `-t`)
      # to (auto)remove them after installation
      installr -d \
      -t "openssl-dev linux-headers autoconf automake zlib-dev" \
      -a "openssl chromium chromium-chromedriver" \
      pagedown

# install plumber
RUN apk add --no-cache --update-cache \
      --repository http://nl.alpinelinux.org/alpine/v3.11/main \
      autoconf=2.69-r2 \
      automake=1.16.1-r0 && \
      # repeat autoconf and automake (under `-t`)
      # to (auto)remove them after installation
      installr -d \
      -t "bash libsodium-dev curl-dev linux-headers autoconf automake" \
      -a libsodium \
      plumber

# install pandoc
RUN wget https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-amd64.tar.gz && \
      tar xzf pandoc-2.13-linux-amd64.tar.gz && \
      mv pandoc-2.13/bin/* /usr/local/bin/ && \
      rm -rf pandoc-2.13*

RUN installr -d -a fontconfig -t fontconfig-dev svglite

COPY pagedown-convert.sh /usr/local/bin/pagedown-convert.sh
COPY api-run.R api-setup.R oregon.png score-report-style.css score-report.Rmd / .

EXPOSE 80

ENTRYPOINT ["Rscript", "api-run.R"]