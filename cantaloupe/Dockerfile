FROM azul/zulu-openjdk-alpine:12

ENV JAVA_OPTS=-Xmx2g

RUN apk add --no-cache \
  wget \
  ghostscript \
  ffmpeg \
  freetype-dev \
  libpng-dev \
  jpeg-dev \
  libjpeg-turbo-dev \
  openjpeg-tools \
  imagemagick

RUN mkdir /cantaloupe && \
  mkdir /cantaloupe/lib && \
  mkdir /cantaloupe/cache && \
  mkdir /cantaloupe/logs && \
  mkdir /cantaloupe/images
WORKDIR /cantaloupe

RUN cd /cantaloupe
RUN wget https://github.com/cantaloupe-project/cantaloupe/releases/download/v4.1.3/cantaloupe-4.1.3.zip -O cantaloupe.zip && \
  unzip cantaloupe.zip -d /cantaloupe && \
  mv ./cantaloupe-4.1.3/cantaloupe-4.1.3.war ./cantaloupe.war && \
  rm -Rf cantaloupe-4.1.3 && \
  rm cantaloupe.zip

COPY ./delegates.rb /cantaloupe
COPY ./cantaloupe.properties /cantaloupe

RUN adduser --system cantaloupe
RUN chown -R cantaloupe: /cantaloupe
USER cantaloupe

EXPOSE 8182
HEALTHCHECK CMD curl --fail http://localhost:8182/ || exit 1
CMD java $JAVA_OPTS -Dcantaloupe.config=/cantaloupe/cantaloupe.properties -jar /cantaloupe/cantaloupe.war