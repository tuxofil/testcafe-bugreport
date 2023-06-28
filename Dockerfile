FROM ubuntu:23.04

ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN set -ex;\
  apt-get update;\
  apt-get install -y ca-certificates curl gnupg adduser tinyproxy tini

# Install the latest stable Google Chrome
RUN set -ex;\
  curl -sSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/chrome.gpg;\
  echo 'deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list;\
  apt-get update;\
  apt-get install -y --no-install-recommends google-chrome-stable

# Install NodeJS 20.x
# Watch new versions at https://nodejs.org/en/about/releases/
RUN set -ex;\
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -;\
  apt-get install -y --no-install-recommends nodejs

# Install TestCafe
# Watch new versions at https://github.com/DevExpress/testcafe/releases
ARG TESTCAFE_VERSION=2.6.2
RUN npm install -g testcafe@$TESTCAFE_VERSION

# create a regular user
RUN set -ex;\
  adduser --disabled-password --gecos '' user;\
  adduser user audio;\
  adduser user video

WORKDIR /home/user

COPY entrypoint.sh script.testcafe tinyproxy.conf .
RUN chmod 0755 entrypoint.sh

USER user
RUN ["/usr/bin/tini", "-s", "--", "/home/user/entrypoint.sh"]
