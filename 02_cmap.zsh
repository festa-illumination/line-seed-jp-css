#!/usr/bin/env zsh

mkdir -p cmap
for f in otf/*.otf; do
  fonttools ttx -t cmap -d cmap ${f}
done
