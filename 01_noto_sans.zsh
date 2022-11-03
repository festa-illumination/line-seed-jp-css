#!/usr/bin/env zsh

curl -L 'https://fonts.googleapis.com/css2?family=Noto+Sans+JP' -o noto_sans.css -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
grep 'unicode-range: ' noto_sans.css | sed -Ee 's/^ *unicode-range: *(.+);$/\1/g' > range_list.txt
