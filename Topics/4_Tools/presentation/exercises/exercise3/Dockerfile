FROM ubuntu:14.04
MAINTAINER YourName <youremail>

#Get up-to-date
RUN apt-get update && apt-get upgrade -y

#Install cowsay
RUN apt-get install -y cowsay

#Copy the file with the saying
COPY my-saying.txt /tmp/my-saying.txt

#Set the default command
CMD /usr/games/cowsay < /tmp/my-saying.txt