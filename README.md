# LINE Seed JP / Web Fonts CSS with Unicode-range

This repository provides a generator of CSS for [LINE Seed JP](https://seed.line.me/index_jp.html) web fonts.

To reduce data to download and to improve performance, the generated CSS uses font splitting with unicode-range fields.

## Usage

```html
<link href="https://cdn.matsurihi.me/line-seed-jp-1.0.1/LINESeedJP_swap.css" rel="stylesheet">

<style>
body {
    font-family: 'LINE Seed JP';
}
</style>
```

You can access non-swap version from `https://cdn.matsurihi.me/line-seed-jp-1.0.1/LINESeedJP.css`.

## How to make

Run scripts from 01 to 06 by this order.

Requirements: fonttools, Ruby, nokogiri

## License

This project is licensed under SIL OPEN FONT LICENSE Version 1.1.
