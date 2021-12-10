FROM ubuntu:20.10

ENV JAVA_OPTS=-Xmx2g


COPY . /build
RUN chmod +x /build/setup.sh
RUN chmod +x /build/entrypoint.sh
RUN /build/setup.sh

EXPOSE 8182
WORKDIR /cantaloupe
HEALTHCHECK CMD curl --fail http://localhost:8182/ || exit 1
CMD ["/build/entrypoint.sh"]