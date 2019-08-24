#!/usr/bin/env perl
$latex      = 'uplatex -halt-on-error -file-line-error %O %S';
$out_dir    = '/workdir';
$bibtex     = 'upbibtex';
$dvipdf     = 'dvipdfmx %O -o %D %S';
$makeindex  = 'upmendex %O -o %D %S';
$max_repeat = 5; # 最大コンパイル回数
$pdf_mode   = 3; # 0: pdf化しない, 1: pdflatexを使用, 2: ps2pdfを使用, 3: dvipdfmxを使用
# %O：実行時オプション
# %S：入力ファイル名
# %D：出力ファイル名
# %B：処理するファイル名の拡張子を除いた文字列

# 古い出力ファイルの保存数
# pdfビューアーにevinceを使用したときに差分を見るために使用
$pvc_view_file_via_temporary = 0;

# 好きなビューアーを指定する
# $pdf_previewer    = "evince";
$pdf_previewer = "ls"; # beacause we use latexmk in a docker container
