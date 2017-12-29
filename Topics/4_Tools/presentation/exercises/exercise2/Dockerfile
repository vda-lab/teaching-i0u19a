FROM ubuntu:14.04
MAINTAINER YourName <youremail>

#Get up-to-date
RUN apt-get update && apt-get upgrade -y

#Install fortune and cowsay
RUN apt-get install -y fortune cowsay

#Set the default command
CMD /usr/games/fortune | /usr/games/cowsay
