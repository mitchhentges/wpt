#!/bin/sh

set -e

if ! command -v gen-bundle > /dev/null 2>&1; then
    echo "gen-bundle is not installed. Please run:"
    echo "  go get -u github.com/WICG/webpackage/go/bundle/cmd/..."
    echo '  export PATH=$PATH:$(go env GOPATH)/bin'
    exit 1
fi

# TODO: Stop hard-coding "web-platform.test" when generating Web Bundles on the
# fly.
wpt_test_origin=https://web-platform.test:8444
wpt_test_remote_origin=https://www1.web-platform.test:8444

gen-bundle \
  -version b1 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/ \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/location.html \
  -dir location/ \
  -o wbn/location.wbn

gen-bundle \
  -version b1 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/ \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/root.js \
  -dir subresource/ \
  -o wbn/subresource.wbn

gen-bundle \
  -version b1 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/static-element/ \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/static-element/resources/style.css \
  -dir static-element/ \
  -o wbn/static-element.wbn

gen-bundle \
  -version b1 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/dynamic/ \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/dynamic/resource1.js \
  -dir dynamic1/ \
  -o wbn/dynamic1.wbn

gen-bundle \
  -version b1 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/dynamic/ \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/dynamic/resource1.js \
  -dir dynamic2/ \
  -o wbn/dynamic2.wbn

gen-bundle \
  -version b1 \
  -baseURL $wpt_test_remote_origin/web-bundle/resources/wbn/dynamic/ \
  -primaryURL $wpt_test_remote_origin/web-bundle/resources/wbn/dynamic/resource1.js \
  -dir dynamic1/ \
  -o wbn/dynamic1-crossorigin.wbn

gen-bundle \
  -version b1 \
  -baseURL $wpt_test_origin/web-bundle/resources/ \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/resource.js \
  -dir path-restriction/ \
  -o wbn/path-restriction.wbn

# Create a bundle, nested-main.wbn, which includes nested-sub.wbn.
cp -a wbn/subresource.wbn nested/nested-sub.wbn
gen-bundle \
  -version b1 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/ \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/resource.js \
  -dir nested/ \
  -o wbn/nested-main.wbn

gen-bundle \
  -version b1 \
  -har urn-uuid.har \
  -primaryURL urn:uuid:020111b3-437a-4c5c-ae07-adb6bbffb720 \
  -o wbn/urn-uuid.wbn

gen-bundle \
  -version b1 \
  -har cross-origin.har \
  -primaryURL $wpt_test_remote_origin/web-bundle/resources/wbn/cors/resource.cors.js \
  -o wbn/cors/cross-origin.wbn

gen-bundle \
  -version b1 \
  -har cross-origin-no-cors.har \
  -primaryURL $wpt_test_remote_origin/web-bundle/resources/wbn/no-cors/resource.cors.js \
  -o wbn/no-cors/cross-origin.wbn

gen-bundle \
  -version b1 \
  -har non-utf8-query-encoding.har \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/static-element/resources/script.js?x=%A4%A2 \
  -o wbn/non-utf8-query-encoding.wbn

gen-bundle \
  -version b1 \
  -har corp.har \
  -primaryURL $wpt_test_remote_origin/web-bundle/resources/wbn/cors/no-corp.js \
  -o wbn/cors/corp.wbn

gen-bundle \
  -version b2 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/ \
  -primaryURL $wpt_test_origin/web-bundle/resources/wbn/location.html \
  -dir location/ \
  -o wbn/location-b2.wbn

gen-bundle \
  -version b2 \
  -har relative-url.har \
  -o wbn/relative-url.wbn

gen-bundle \
  -version b2 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/ \
  -dir subresource/ \
  -o wbn/subresource-b2.wbn

gen-bundle \
  -version b2 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/dynamic/ \
  -dir dynamic1/ \
  -o wbn/dynamic1-b2.wbn

gen-bundle \
  -version b2 \
  -baseURL $wpt_test_origin/web-bundle/resources/wbn/dynamic/ \
  -dir dynamic2/ \
  -o wbn/dynamic2-b2.wbn

gen-bundle \
  -version b2 \
  -baseURL $wpt_test_remote_origin/web-bundle/resources/wbn/dynamic/ \
  -dir dynamic1/ \
  -o wbn/dynamic1-crossorigin-b2.wbn

gen-bundle \
  -version b2 \
  -baseURL $wpt_test_origin/web-bundle/resources/ \
  -dir path-restriction/ \
  -o wbn/path-restriction-b2.wbn

gen-bundle \
  -version b2 \
  -har urn-uuid.har \
  -o wbn/urn-uuid-b2.wbn

gen-bundle \
  -version b2 \
  -har cross-origin.har \
  -o wbn/cors/cross-origin-b2.wbn

gen-bundle \
  -version b2 \
  -har cross-origin-no-cors.har \
  -o wbn/no-cors/cross-origin-b2.wbn

gen-bundle \
  -version b2 \
  -har uuid-in-package.har \
  -o wbn/uuid-in-package.wbn
