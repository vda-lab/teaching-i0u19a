FROM mongo
MAINTAINER Jan Aerts <jan.aerts@kuleuven.be>
ENV REFRESHED_AT 2016-04-15

RUN apt-get update && apt-get upgrade -y
EXPOSE 27017
EXPOSE 28017

ADD beers.json /startup/beers.json

RUN mkdir ~/mongo

# Starting things up
RUN mkdir -p /startup
ADD docker-startup.sh /startup/docker-startup.sh
RUN chmod a+x /startup/docker-startup.sh

CMD ["/bin/sh", "/startup/docker-startup.sh"]
