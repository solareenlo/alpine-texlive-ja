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

### 索引を出力する
- 上記の`sudo docker-compose up`を実行する前に以下を行う.
```bash
sudo docker run --rm -it -v $PWD:/workdir solareenlo/alpine-texlive-ja /bin/bash -c "uplatex main.tex && makeindex main.idx && uplatex main.tex && dvipdfmx main.dvi"
```

### Dockerコンテナを使って手動でコンパイルする方法
```bash
# Dockerの中に入らずにコンパイルする
sudo docker run --rm -it -v $PWD:/workdir solareenlo/alpine-texlive-ja /bin/bash -c "uplatex main.tex && dvipdfmx main.dvi"
```
```bash
# Dockerの中に入ってコンパイルする
sudo docker run --rm -it -v $PWD:/workdir solareenlo/alpine-texlive-ja
latexmk -C main.tex && latexmk main.tex && latexmk -c main.tex
```

### コードのシンタックスハイライトで使用できる色を確認する
- コードのシンタックスハイライトに`minted`を使用しているとして，以下を実行する.

```bash
sudo docker-compose exec texlive sh
pygmentize -L styles
```

- そして，標準出力に出てきたお好きな色の様式を選んで，プリアンブルに以下のように記入する．

```tex
\usepackage[dvipdfmx]{graphicx, xcolor} % colorを使う

\definecolor{monokai}{HTML}{282828} % monokaiのバックグラウンドカラー
\usemintedstyle{monokai} % monokaiのフォントカラーを使う

\usemintedstyle{vs}

\usemintedstyle{solarized-dark}
\usemintedstyle{solarized-light}

% Solarized colors
\definecolor{sbase03}{HTML}{002B36}
\definecolor{sbase02}{HTML}{073642}
\definecolor{sbase01}{HTML}{586E75}
\definecolor{sbase00}{HTML}{657B83}
\definecolor{sbase0}{HTML}{839496}
\definecolor{sbase1}{HTML}{93A1A1}
\definecolor{sbase2}{HTML}{EEE8D5}
\definecolor{sbase3}{HTML}{FDF6E3}
\definecolor{syellow}{HTML}{B58900}
\definecolor{sorange}{HTML}{CB4B16}
\definecolor{sred}{HTML}{DC322F}
\definecolor{smagenta}{HTML}{D33682}
\definecolor{sviolet}{HTML}{6C71C4}
\definecolor{sblue}{HTML}{268BD2}
\definecolor{scyan}{HTML}{2AA198}
\definecolor{sgreen}{HTML}{859900}
```

## Contribute
PRs accepted.

## License
MIT © solareenlo

## References
- [frol/docker-alpine-glibc](https://github.com/frol/docker-alpine-glibc)
- [Paperist/docker-alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja)
- [モダンなLaTexで書いたレポートを簡単にdockerでPDFに変換してCIで配布する方法](https://qiita.com/eisoku9618/items/423a3638a727ea2846d5)
- [zegervdv/homebrew-zathura](https://github.com/zegervdv/homebrew-zathura)
