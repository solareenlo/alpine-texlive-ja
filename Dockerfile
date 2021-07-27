# Copyright (c) 2015 Vlad
# Copyright (c) 2016 Kaito Udagawa
# Copyright (c) 2016-2020 3846masa
# Copyright (c) 2020-2021 solareenlo
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM frolvlad/alpine-glibc:latest

ENV PATH /usr/local/texlive/2021/bin/x86_64-linuxmusl:$PATH

# Reference: https://github.com/Paperist/docker-alpine-texlive-ja
# install texlive
RUN apk add --no-cache curl perl fontconfig-dev freetype-dev py-pygments && \
    apk add --no-cache --virtual .fetch-deps wget xz tar && \
    mkdir /tmp/install-tl-unx && \
    wget -qO - ftp://tug.org/historic/systems/texlive/2021/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "tlpdbopt_install_docfiles 0" \
      "tlpdbopt_install_srcfiles 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    tlmgr install \
      collection-basic\
      collection-latex \
      collection-latexrecommended\
      collection-latexextra \
      collection-fontsrecommended\
      collection-langjapanese \
      latexmk \
      minted \
      dvipdfmx && \
    (tlmgr install xetex || exit 0) && \
    rm -fr /tmp/install-tl-unx && \
    apk del .fetch-deps

# TEXMF = /usr/local/texlive/2021/texmf-dist/

# install noto font jp
# フォントをインストールする場所は以下で探し, /fonts/以下は自由なディレクトリが可能.
# $ kpsewhich -var-value=TEXMFLOCAL
RUN mkdir -p /usr/local/texlive/texmf-local/fonts/opentype/google && \
    cd /usr/local/texlive/texmf-local/fonts/opentype/google/ && \
    # 以下はgoogle noto font cjkのjpフォントだけをインストールしている.
    wget https://github.com/googlefonts/noto-cjk/raw/main/Sans/SubsetOTF/JP/NotoSansJP-Black.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Sans/SubsetOTF/JP/NotoSansJP-Bold.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Sans/SubsetOTF/JP/NotoSansJP-DemiLight.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Sans/SubsetOTF/JP/NotoSansJP-Light.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Sans/SubsetOTF/JP/NotoSansJP-Medium.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Sans/SubsetOTF/JP/NotoSansJP-Regular.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Sans/SubsetOTF/JP/NotoSansJP-Thin.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Serif/NotoSerifJP-Black.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Serif/NotoSerifJP-Bold.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Serif/NotoSerifJP-ExtraLight.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Serif/NotoSerifJP-Light.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Serif/NotoSerifJP-Medium.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Serif/NotoSerifJP-Regular.otf \
         https://github.com/googlefonts/noto-cjk/raw/main/Serif/NotoSerifJP-SemiBold.otf && \
    mktexlsr
# 明朝体・細字（\mcfamily\ltseries）
# 明朝体・中字（\mcfamily\mdseries）
# 明朝体・太字（\mcfamily\bfseries）
# ゴシック体・中字（\gtfamily\mdseries）
# ゴシック体・太字（\gtfamily\bfseries）
# ゴシック体・極太（\gtfamily\ebseries）
# 丸ゴシック体（\mgfamily）
# 上記の7つのフォントを使うには, `.texファイル`のプリアンブルに以下の2行を追加する.
# \usepackage[deluxe]{otf}% 多書体設定
# \usepackage[noto-jp]{pxchfon}% 後に読み込む

WORKDIR /workdir

CMD ["sh"]

# References
# - https://github.com/frol/docker-alpine-glibc
# - https://github.com/Paperist/docker-alpine-texlive-ja
# - https://github.com/vvakame/docker-review/blob/master/review-3.2/Dockerfile
