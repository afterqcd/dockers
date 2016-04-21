# dockerfile to build kibana image
# Version: 1.0.0 
FROM afterqcd/elasticsearch:v2.3.1
MAINTAINER Afterqcd "afterqcd@gmail.com"

ADD kibana-4.5.0-linux-x64.tar.gz /usr/
RUN mv /usr/kibana-4.5.0-linux-x64 /usr/kibana
ENV PATH /usr/kibana/bin:$PATH
RUN kibana plugin --install elasticsearch/marvel/2.3.1
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["-e", "http://node1:9200"]
