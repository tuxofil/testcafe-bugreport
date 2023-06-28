#!/bin/sh -ex

# spawn the proxy server
tinyproxy -c /home/user/tinyproxy.conf

# warmup proxy server
sleep 3s

/usr/bin/testcafe \
    "chrome:/usr/bin/google-chrome-stable:headless --disable-dev-shm-usage" \
    --reporter=json \
    --proxy 127.0.0.1:8888 \
    script.testcafe

# dump proxy server logs
cat -n tinyproxy.log
