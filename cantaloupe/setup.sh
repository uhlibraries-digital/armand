#!/bin/bash

# Install some packages used by the application
apt-get update
apt-get install --yes --no-install-recommends apt-utils
apt-get install --yes --no-install-recommends unzip
apt-get install --yes --no-install-recommends wget
apt-get install --yes --no-install-recommends ca-certificates
apt-get install --yes openjdk-8-jre-headless
apt-get install --yes --no-install-recommends imagemagick
apt-get install --yes --no-install-recommends ghostscript
apt-get install --yes --no-install-recommends libmagickcore-6.q16-2-extra
apt-get install --yes --no-install-recommends ffmpeg
apt-get install --yes --no-install-recommends graphicsmagick
apt-get install --yes --no-install-recommends curl
apt-get install --yes --no-install-recommends libopenjp2-7-dev
apt-get install --yes --no-install-recommends libopenjp2-tools
apt-get install --yes --no-install-recommends libgs-dev

# Install gosu
dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"
wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-$dpkgArch"
chmod +x /usr/local/bin/gosu

# Create directories
mkdir /cantaloupe
mkdir /cantaloupe/lib
mkdir /cantaloupe/cache
mkdir /cantaloupe/logs
mkdir /cantaloupe/images

# Download Cantaloupe
wget -q "https://github.com/cantaloupe-project/cantaloupe/releases/download/v4.1.2/cantaloupe-4.1.2.zip" -O "/cantaloupe/cantaloupe.zip"
unzip /cantaloupe/cantaloupe.zip -d /cantaloupe
mv /cantaloupe/cantaloupe-4.1.2/cantaloupe-4.1.2.war /cantaloupe/cantaloupe.war
mv /build/cantaloupe.properties /cantaloupe/cantaloupe.properties
mv /build/delegates.rb /cantaloupe/delegates.rb
rm -Rf /cantaloupe/cantaloupe-4.1.2
rm /cantaloupe/cantaloupe.zip

