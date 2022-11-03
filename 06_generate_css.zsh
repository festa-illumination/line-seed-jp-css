#!/usr/bin/env zsh

FILE=dist/LINESeedJP_swap.css

echo -n '' > $FILE

for f in otf/*.otf; do
  BASENAME=${${f%.*}#*/}

  if [[ $BASENAME =~ '_Th' ]]; then
    WEIGHT=100
  elif [[ $BASENAME =~ '_Rg' ]]; then
    WEIGHT=400
  elif [[ $BASENAME =~ '_Bd' ]]; then
    WEIGHT=700
  elif [[ $BASENAME =~ '_Eb' ]]; then
    WEIGHT=800
  fi

  I=0
  while read LINE; do
    MD5=$(echo 'こんなにドキドキするなんてまぎれもなくあなたのせいなんです' $BASENAME $I | md5sum | cut -d ' ' -f 1)

    echo '@font-face {' >> $FILE
    echo "  font-family: 'LINE Seed JP';" >> $FILE
    echo "  font-style: normal;" >> $FILE
    echo "  font-weight: ${WEIGHT};" >> $FILE
    echo "  font-display: swap;" >> $FILE
    echo "  src: url('./${BASENAME}/woff2/${MD5}.woff2') format('woff2'), url('./${BASENAME}/woff/${MD5}.woff') format('woff');" >> $FILE
    echo "  unicode-range: ${LINE};" >> $FILE
    echo '}' >> $FILE

    I=$(($I + 1))
  done < range/${BASENAME}.txt
done

cat $FILE | grep -v 'font-display: swap;' > dist/LINESeedJP.css
