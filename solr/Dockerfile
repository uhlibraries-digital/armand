FROM solr:6.6

USER root

RUN mkdir -p /opt/solr/server/solr/configsets/armand/conf
COPY ./config/* /opt/solr/server/solr/configsets/armand/conf/
RUN chown -R solr:solr /opt/solr/server/solr/configsets/armand

USER solr