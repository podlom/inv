#!/bin/bash
rm error
for l in `grep '<loc>' ../www/sitemap.xml | egrep -o "https?://[^<]+"`; do echo $l; curl --fail --silent --show-error -o /dev/null $l; [ $? -eq 0 ] || echo $l >> error; done;
