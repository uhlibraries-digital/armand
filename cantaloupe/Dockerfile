FROM ubuntu:22.04

ENV JAVA_OPTS=-Xmx2g

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  ca-certificates \
  imagemagick \
  libmagickcore-6.q16-2-extra \
  ghostscript \
  ffmpeg \
  graphicsmagick \
  curl \
  libopenjp2-7-dev \
  libopenjp2-tools \
  libgs-dev \
  openjdk-11-jre-headless

RUN mkdir /cantaloupe && \
  mkdir /cantaloupe/lib && \
  mkdir /cantaloupe/cache && \
  mkdir /cantaloupe/logs && \
  mkdir /cantaloupe/images
WORKDIR /cantaloupe

RUN cd /cantaloupe
RUN wget -q https://github.com/cantaloupe-project/cantaloupe/releases/download/v4.1.11/cantaloupe-4.1.11.zip -O cantaloupe.zip && \
  unzip cantaloupe.zip -d /cantaloupe && \
  mv ./cantaloupe-4.1.11/cantaloupe-4.1.11.war ./cantaloupe.war && \
  rm -Rf cantaloupe-4.1.11 && \
  rm cantaloupe.zip

COPY ./delegates.rb /cantaloupe
COPY ./cantaloupe.properties /cantaloupe

RUN groupadd --system --gid 999 cantaloupe
RUN useradd --uid 999 --gid 999 --system --shell /bin/false cantaloupe
RUN chown -R cantaloupe: /cantaloupe
USER cantaloupe

EXPOSE 8182
HEALTHCHECK CMD curl --fail http://localhost:8182/ || exit 1
CMD java $JAVA_OPTS -Dcantaloupe.config=/cantaloupe/cantaloupe.properties -jar /cantaloupe/cantaloupe.war