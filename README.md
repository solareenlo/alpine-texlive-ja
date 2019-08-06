# solareenlo/alpine-texlive-ja
[![Docker Automated build](https://img.shields.io/docker/automated/solareenlo/alpine-texlive-ja.svg)](https://hub.docker.com/r/solareenlo/alpine-texlive-ja/)
[![Docker Image Size](https://images.microbadger.com/badges/image/solareenlo/alpine-texlive-ja.svg)](https://microbadger.com/images/solareenlo/alpine-texlive-ja "Get your own image badge on microbadger.com")

> Minimal TeX Live image for Japanese based on alpine

Forked from [umireon/docker-texci](https://github.com/umireon/docker-texci) \(under the MIT License\).

Forked from [Paperist/docker-alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja) \(under the MIT License\).

## Usage
### docker-composeを使って自動でコンパイルする方法
```bash
git clone git@github.com:solareenlo/docker-alpine-texlive-ja.git
cd docker-alpine-texlive-ja
touch main.tex
# 以下で`.tex`>`.dvi`>`.pdf`の流れで`.pdf`が自動生成される.
sudo docker-compse up
```
- 別のターミナルを開いてそこで`main.tex`を編集する.
- `.pdf`を確認するには, pdfビューアーの`zathura`を使うとvimのキーバインドで閲覧, 操作ができる.
```bash
sudo apt update
sudo apt install zathura
# --forkをつけるとバックグラウンドでzathuraが起動する.
zathura --fork main.pdf
```

### Dockerコンテナを使って手動でコンパイルする方法
```bash
# Dockerの中に入らずにコンパイルする
sudo docker run --rm -it -v $PWD:/workdir solareenlo/alpine-texlive-ja /bin/bash -c "platex main.tex && dvipdfmx main.dvi"
```
```bash
# Dockerの中に入ってコンパイルする
sudo docker run --rm -it -v $PWD:/workdir solareenlo/alpine-texlive-ja
latexmk -C main.tex && latexmk main.tex && latexmk -c main.tex
```

## Contribute
PRs accepted.

## License
MIT © solareenlo

## References
- [frol/docker-alpine-glibc](https://github.com/frol/docker-alpine-glibc)
- [Paperist/docker-alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja)
- [モダンなLaTexで書いたレポートを簡単にdockerでPDFに変換してCIで配布する方法](https://qiita.com/eisoku9618/items/423a3638a727ea2846d5)
