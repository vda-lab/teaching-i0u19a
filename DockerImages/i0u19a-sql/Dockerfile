FROM ubuntu:14.04
MAINTAINER Jan Aerts <jan.aerts@kuleuven.be>
ENV REFRESHED_AT 2017-02-16

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nano
RUN apt-get install -y sqlite3
EXPOSE 22

WORKDIR /work
ADD friends.sqlite /work/friends.sqlite

CMD ["/bin/bash"]