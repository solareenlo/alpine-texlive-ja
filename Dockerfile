# Copyright (c) 2016 Kaito Udagawa
# Copyright (c) 2016-2019 3846masa
# Copyright (c) 2019 solareenlo
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM frolvlad/alpine-glibc

ENV PATH /usr/local/texlive/2019/bin/x86_64-linux:$PATH

RUN apk --no-cache add perl wget xz tar fontconfig-dev freetype-dev && \
    mkdir /tmp/install-tl-unx && \
    wget -qO - ftp://tug.org/historic/systems/texlive/2019/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    tlmgr install \
      collection-basic collection-latex \
      collection-latexrecommended collection-latexextra \
      collection-fontsrecommended collection-langjapanese \
      latexmk && \
    (tlmgr install xetex || exit 0) && \
    rm -fr /tmp/install-tl-unx && \
    apk --no-cache del xz tar

RUN apk --no-cache add bash

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
