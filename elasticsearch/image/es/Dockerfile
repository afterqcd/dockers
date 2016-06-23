# dockerfile to build elastic-search image
# Version: 1.0.0 
FROM afterqcd/java:v1.8
MAINTAINER Afterqcd "afterqcd@gmail.com"

# Setup gosu for easier command execution
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
  && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64.asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && rm -r /root/.gnupg/ \
  && chmod +x /usr/local/bin/gosu

# Install elasticsearch
RUN useradd elasticsearch
ADD https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.3.1/elasticsearch-2.3.1.zip /usr/
RUN mv /usr/elasticsearch-2.3.1 /usr/elasticsearch
ENV PATH /usr/elasticsearch/bin:$PATH
RUN plugin install license
RUN plugin install -b marvel-agent
ADD https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v1.9.1/elasticsearch-analysis-ik-1.9.1.zip /usr/elasticsearch/plugins/
RUN chown -R elasticsearch:elasticsearch /usr/elasticsearch

VOLUME /usr/elasticsearch/data
COPY docker-entrypoint.sh /
EXPOSE 9200 9300

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
