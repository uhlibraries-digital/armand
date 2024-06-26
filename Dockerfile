FROM ruby:2.5.7

ENV APP_PATH=/armand-app

RUN apt-get update -q && apt-get install -y \
  build-essential \
  nodejs \
  ffmpeg \
  mediainfo \
  libreoffice \
  imagemagick \
  zip \
  git \
  openjdk-11-jre \
  ghostscript \
  ghostscript-x

# Fix ImageMagick resource disk limit policy
RUN sed -i 's|<policy domain="resource" name="disk" value="1GiB"/>|<!-- <policy domain="resource" name="disk" value="1GiB"/> -->|g' /etc/ImageMagick-6/policy.xml 

RUN mkdir /armand-app
WORKDIR /armand-app

ADD Gemfile /armand-app/Gemfile
ADD Gemfile.lock /armand-app/Gemfile.lock

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN mkdir -p /opt/fits && \
  cd /opt/fits && \
  wget -q https://github.com/harvard-lts/fits/releases/download/1.5.0/fits-1.5.0.zip -O fits.zip && \
  unzip fits.zip && \
  rm fits.zip && \
  chmod a+x /opt/fits/fits.sh && \
  touch /opt/fits/fits.log && \
  chmod a+w /opt/fits/fits.log && \
  rm -f /opt/fits/tools/mediainfo/linux/libmediainfo.so.0 && \
  rm -f /opt/fits/tools/mediainfo/linux/libzen.so.0
ENV PATH="${PATH}:/opt/fits"

RUN mkdir -p /app/valkyrie 
COPY ./vendor/valkyrie/valkyrie-2.0.0rc2.gem /app/valkyrie/valkyrie-2.0.0rc2.gem
RUN cd /app/valkyrie && \
  gem install -q dry-core -v 0.6.0 && \
  gem install -q dry-configurable -v 0.12.1 && \
  gem install -q dry-container -v 0.7.2 && \
  gem install -q nokogiri -v 1.12.5 && \
  gem install -q rails-html-sanitizer -v 1.5.0 && \
  gem install -q thor -v 1.2.2
RUN gem install /app/valkyrie/valkyrie-2.0.0rc2.gem

RUN gem install bundler -v 2.3.26 && bundle install
ADD . /armand-app