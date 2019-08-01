# solareenlo/alpine-texlive-ja

[![Docker Automated build](https://img.shields.io/docker/automated/solareenlo/alpine-texlive-ja.svg)](https://hub.docker.com/r/solareenlo/alpine-texlive-ja/)
[![Docker Image Size](https://images.microbadger.com/badges/image/solareenlo/alpine-texlive-ja.svg)](https://microbadger.com/images/solareenlo/alpine-texlive-ja "Get your own image badge on microbadger.com")

> Minimal TeX Live image for Japanese based on alpine

Forked from [umireon/docker-texci](https://github.com/umireon/docker-texci) \(under the MIT License\).

Forked from [Paperist/docker-alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja) \(under the MIT License\).

## Table of Contents

- [Install](#install)
- [Usage](#usage)
- [Contribute](#contribute)
- [License](#license)

## Install

```bash
docker pull solareenlo/alpine-texlive-ja
```

## Usage

```bash
$ docker run --rm -it -v $PWD:/workdir solareenlo/alpine-texlive-ja
$ latexmk -C main.tex && latexmk main.tex && latexmk -c main.tex
```

## Contribute

PRs accepted.

## License

MIT © solareenlo
