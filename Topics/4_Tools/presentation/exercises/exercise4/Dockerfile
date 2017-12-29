FROM ubuntu:14.04
MAINTAINER YourName <youremail>

#Get up-to-date
RUN apt-get update && apt-get upgrade -y

#Install cowsay
RUN apt-get install -y cowsay

#Make working directory
RUN mkdir /work

#Set the default command
CMD /usr/games/cowsay < /work/my-saying.txt