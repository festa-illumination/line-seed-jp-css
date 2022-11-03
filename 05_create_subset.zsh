#!/usr/bin/env zsh

for f in otf/*.otf; do
  BASENAME=${${f%.*}#*/}
  mkdir -p dist/${BASENAME}/{woff,woff2}
  I=0
  while read LINE; do
    MD5=$(echo 'こんなにドキドキするなんてまぎれもなくあなたのせいなんです' $BASENAME $I | md5sum | cut -d ' ' -f 1)
    pyftsubset $f --unicodes="${LINE}" --layout-features+=palt --output-file=dist/${BASENAME}/woff/${MD5}.woff --flavor=woff --with-zopfli
    pyftsubset $f --unicodes="${LINE}" --layout-features+=palt --output-file=dist/${BASENAME}/woff2/${MD5}.woff2 --flavor=woff2
    I=$(($I + 1))
  done < range/${BASENAME}.txt
done
