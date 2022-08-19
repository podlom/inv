# Node Sitemap Generator

## Manpage
- -u, --url <url>', 'url to start crawling'
- -I, --include-images', 'Include images in the sitemap according to the image sitemap spec')
- -s, --sitemap <sitemap.xml>', 'path where sitemap.xml will be saved', '/tmp/sitemap.xml')
- -i, --ignore <regex>', 'Regex for a url to be ignored (repeatable)', collect, [])
- -a, --additonalurls <urlfile>', 'File containing additional urls to crawl (one per line)')
- -d, --max-depth <depth>', 'Max crawling depth')


### Example
```
/usr/local/bin/node [PATH SITEMAP-CRAWLER/APP.JS] -u [DOMAIN] -s [PATH TO SITEMAP.XML] -i [IGNORE AS REGEX]  
```
