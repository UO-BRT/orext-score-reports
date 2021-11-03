FROM rhub/r-minimal
RUN apk add --no-cache --update-cache ttf-opensans

# install rmarkdown ggplot2 and svglite
RUN installr -d rmarkdown 
RUN installr -d -t gfortran ggplot2
RUN installr -d -a fontconfig -t fontconfig-dev svglite

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

# install showtext
RUN apk add --no-cache --update-cache \
      --repository http://nl.alpinelinux.org/alpine/v3.11/main \
      autoconf=2.69-r2 \
      automake=1.16.1-r0 && \
      # repeat autoconf and automake (under `-t`)
      # to (auto)remove them after installation
      installr -d \
      -t "zlib-dev libpng-dev freetype-dev" \
      -a "zlib libpng freetype" \
      showtext

# install pandoc
RUN wget https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-amd64.tar.gz && \
      tar xzf pandoc-2.13-linux-amd64.tar.gz && \
      mv pandoc-2.13/bin/* /usr/local/bin/ && \
      rm -rf pandoc-2.13*

COPY render.sh /usr/local/bin/render.sh
COPY convert-pdf.sh /usr/local/bin/convert-pdf.sh
COPY oregon.png score-report-style.css score-report.Rmd / .

RUN chmod +x /usr/local/bin/render.sh
RUN chmod +x /usr/local/bin/convert-pdf.sh