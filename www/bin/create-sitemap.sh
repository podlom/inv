#!/bin/bash

# Beispiel
#/usr/bin/node /var/node/apps/sitemap-crawler/app.js -u https://inventure.com.ua/ -s /home/inventure/data/web/inventure.com.ua/www/new_sitemap.xml -i "/api/" -i "/website/static/" -i "/admin" -i "/uk/service/search" -i "/uk/newsletter-confirm" -a "/home/inventure/data/web/inventure.com.ua/www/bin/sitemap-crawler/additional-sitemap-urls.txt"

# Set default binary for node
BINARY="/usr/bin/node";

# Check if binary for node exists
if [ ! -f $BINARY ];
then
    BINARY="/usr/local/bin/node";
fi;

# Init Variables

# Languages of Site
SITE_LANGUAGES=(ru uk en)

# Excludes (as regular expressions, the last one excludes recursively added GET parameters)
EXCLUDES=("/website/static/" "data:image" "%3F.+%3D")

# Base information for url
PROTOCOL="https://"
DOMAIN="inventure.com.ua"
SYSTEM_BASE_URL="$PROTOCOL$DOMAIN"

# Directories
CURRENT_DIR="${PWD}"
DOCUMENT_ROOT="$CURRENT_DIR/.."
SITEMAP_TARGET="$DOCUMENT_ROOT/www/bin/sitemaps"

for lang in ${SITE_LANGUAGES[@]}; do

    URL="$SYSTEM_BASE_URL/${lang}"
    TARGET="$SITEMAP_TARGET/new_sitemap_${lang}.xml"

    IGNORES=""
    for i in ${EXCLUDES[@]}; do

        IGNORES="$IGNORES-i ${i} "

    done

    # Exclude other languages
    for ign_lang in ${SITE_LANGUAGES[@]}; do

        if [ ${ign_lang} != ${lang} ]
        then
            IGNORES="$IGNORES-i ^/${ign_lang} "
        fi

    done

    # Output
    echo "Starting generating Sitemap for $URL"
    echo "$BINARY $CURRENT_DIR/sitemap-crawler/app.js -I -u $URL -s $TARGET $IGNORES"

    # Perform command
    $BINARY $CURRENT_DIR/sitemap-crawler/app.js -I -u $URL -s $TARGET $IGNORES

done
