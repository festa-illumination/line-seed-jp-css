#!/usr/bin/env zsh

mkdir -p
for f in otf/*.otf; do
  fonttools ttx -t cmap -d cmap ${f}
done
