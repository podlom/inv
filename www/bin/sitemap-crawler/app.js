var sm = require('sitemap')
    , Crawler = require('simplecrawler')
    , _ = require('underscore')
    , program = require('commander')
    , url = require('url')
    , fs = require('fs')
    , cheerio = require('cheerio')
    , https = require('https')
    ;

_.str = require('underscore.string');


function canWrite(owner, inGroup, mode) {
    return owner && (mode & 00200) || // User is owner and owner can write.
        inGroup && (mode & 00020) || // User is in group and group can write.
        (mode & 00002); // Anyone can write.
}

function collect(val, memo) {
    memo.push(val);
    return memo;
}


program
    .version('1.0.0')
    .option('-u, --url <url>', 'url to start crawling')
    .option('-I, --include-images', 'Include images in the sitemap according to the image sitemap spec')
    .option('-s, --sitemap <sitemap.xml>', 'path where sitemap.xml will be saved', '/tmp/sitemap.xml')
    .option('-i, --ignore <regex>', 'Regex for a url to be ignored (repeatable)', collect, [])
    .option('-a, --additonalurls <urlfile>', 'File containing additional urls to crawl (one per line)')
    .option('-d, --max-depth <depth>', 'Max crawling depth')
    .option('-c, --credentials <user:password>', 'Credentials for basic auth')
;

try {
    program.parse(process.argv);

    var urlInfo = url.parse(program.url);
    var sitemapPath = program.sitemap;
    var additionalUrlFile = program.additonalurls;

    // var ignored = program.ignore || '';
    // var ignoredUrls = _.map((program.ignore || '').split(','), _.str.trim);

    var ignoreRegex = null;

    if (!_.isEmpty(program.ignore)) {
        ignoreRegex = new RegExp(program.ignore.join('|'));
    }


    var host = urlInfo.protocol + '//' + urlInfo.host;


    var crawler = new Crawler(program.url);
    // crawler.httpsAgent = new https.Agent({
    //     rejectUnauthorized: true,
    //     keepAlive: true,                // workaround part i.
    //                                     // shouldn't be used in AWS Lambda functions
    //     secureProtocol: "TLSv1_method", // workaround part ii.
    //     ciphers: "ALL"                  // workaround part ii.
    // });

    // crawler.initialProtocol = urlInfo.protocol.replace(/:$/, '');
    // if (urlInfo.port) {
    //     crawler.initialPort = urlInfo.port;
    // }

    if (program.credentials && program.credentials.indexOf(':') >= 0) {
        var credentials = program.credentials.split(':');
        crawler.needsAuth = true;
        crawler.authUser = credentials[0];
        crawler.authPass = credentials[1];
    }

    if (program.maxDepth) {
        var depth = parseInt(program.maxDepth);

        if (depth > 0) {
            crawler.maxDepth = depth;
        }
    }

    var sitemap = sm.createSitemap({
        hostname: host
    });

    crawler.downloadUnsupported = false;
    crawler.supportedMimeTypes = [
        /^text\/html/i,
        /^application\/(rss|html|xhtml)?[\+\/\-]?xml/i,
        /^xml/i
    ];

    if (ignoreRegex) {
        crawler.addFetchCondition(function (queueItem, referrerQueueItem) {
            return !ignoreRegex.test(queueItem.path);
        });
    }

    crawler.on("fetchcomplete", function (queueItem, responseBuffer, response) {
        console.log("Fetched URL %s (%d bytes)", queueItem.url, responseBuffer.length);

        if (ignoreRegex && ignoreRegex.test(queueItem.url)) {
            return;
        }

        if (!_.str.startsWith(response.headers['content-type'], 'text/html')) {
            return;
        }

        var images = [];

        if (program.includeImages) {
            var $ = cheerio.load(responseBuffer.toString("utf8"));

            images = $("img").map(function () {
                var imgUrl = $(this).attr("src");

                if (ignoreRegex && ignoreRegex.test(imgUrl)) {
                    return null;
                }

                var caption = $(this).attr("title") || $(this).attr("alt") || '';

                if (_.str.startsWith(imgUrl, '/')) {
                    var imageUrlInfo = url.parse(queueItem.url);

                    imgUrl = imageUrlInfo.protocol + '//' + imageUrlInfo.host + imgUrl;
                } else if (!(/https?:\/\//.test(imgUrl))) {
                    imgUrl = queueItem.url + '/' + imgUrl;
                }

                return {url: imgUrl, caption: caption};
            }).get();

            images = _.compact(images);
        }

        var props = {
            url: queueItem.url,
            changefreq: 'daily',
            priority: 1.0
        };

        if (!_.isEmpty(images)) {
            props.img = images;
        }

        sitemap.add(props);

    });

    crawler.on('fetchdisallowed', function (item) {
        console.log('Unable to fetch ' + item.url + ' due to robots.txt restrictions');
    });
    crawler.on('queueerror', function (item, response) {
        console.log('queueerror', response.statusCode);
    });
    crawler.on('fetchclienterror', function (item, errorData) {
        console.log('fetchclienterror', errorData);
    });

    crawler.on("complete", function () {
        console.log('Crawling finished. Sitemap written to ' + sitemapPath);

        process.nextTick(function () {
            sitemap.toXML(function (err, xml) {
                if (err) {
                    console.error('Unable to transform sitemap to xml', err);
                    return;
                }

                fs.writeFile(sitemapPath, xml, function (err) {
                    if (err) {
                        console.error('Unable to write sitemap at path "' + sitemapPath + '"', err);
                    }
                });
            });
        });
    });

    var start = function () {
        crawler.start();
    };

    if (additionalUrlFile) {
        var stat = fs.statSync(additionalUrlFile);

        if (stat.isFile()) {
            var lineReader = require('readline').createInterface({
                input: require('fs').createReadStream(additionalUrlFile)
            });

            lineReader.on('line', function (line) {
                crawler.queueURL(line);
            });

            lineReader.on('close', function () {
                start();
            });
        } else {
            start();
        }
    } else {
        start();
    }


} catch (e) {
    console.error('ERROR: %s', e);
    program.help();
}
