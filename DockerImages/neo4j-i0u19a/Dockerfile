FROM neo4j:2.3
MAINTAINER Jan Aerts <jan.aerts@kuleuven.be>
ENV REFRESHED_AT 2016-04-28c

RUN sed -i.bak 's/dbms.security.auth_enabled=true/dbms.security.auth_enabled=false/' /var/lib/neo4j/conf/neo4j-server.properties
#RUN sed -i.bak 's/org.neo4j.server.webserver.address=0.0.0.0/#org.neo4j.server.webserver.address=0.0.0.0/' /var/lib/neo4j/conf/neo4j-server.properties
RUN echo "node_auto_indexing=true" >> /var/lib/neo4j/conf/neo4j.properties
RUN echo "node_keys_indexable=name" >> /var/lib/neo4j/conf/neo4j.properties
EXPOSE 7474

RUN mkdir -p /startup
ADD docker-startup.sh /startup/docker-startup.sh
ADD gene-nodes.txt /startup/gene-nodes.txt
ADD disease-nodes.txt /startup/disease-nodes.txt
ADD gene-disease_relationships.txt /startup/gene-disease_relationships.txt
ADD gene-gene_relationships.txt /startup/gene-gene_relationships.txt
RUN chmod a+x /startup/docker-startup.sh

CMD ["/bin/sh", "/startup/docker-startup.sh"]
