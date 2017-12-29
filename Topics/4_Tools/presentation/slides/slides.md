## Reproducible education and research:<br/>Introduction to Docker

Jan Aerts

![kuleuven-logo](/images/KULeuven-logo-2012.png)
![stadius-logo](/images/logo_stadius-small.png)
![vda-logo](/images/my_version_transparent.gif)

--NEWH
# :: Why? ::

--NEWH
## 1. Teaching

--NEWV
[I0U19A] Management of Large-Scale Omics Data

* Lambda architecture
* Data storage: key/value stores, graph databases (neo4j, ...), document-oriented databases (mongodb, ...)
* Data processing: hadoop, spark

--NEWV
Need running (linux) system for demo and exercises.

Previous years:

* Amazon AWS EC2
* Grant from Amazon 2013-2015: $3,000
* Heavily annotated setup script
  * Install software
  * Create user accounts
  * Allow remote logins
  * ...

--NEWV
In 2016:

* Grant from Amazon to run server: $75 (seventy-five)
* Fed up with spending time debugging software installation

--NEWH
## 2. Software distribution

--NEWV
NGS Logistics?

![ngs-logistics](/images/ngs-logistics.png)

Endeavour?

--NEWV
"An Introduction to Docker for Reproducible Research" (Carl Boettiger)

--NEWV
Challenges:

* dependency hell
* imprecise documentation
* code rot
* barriers to adoption and reuse in existing solutions

Note:
* Need to recreate the computational environment of the original researchers
* Incomplete documentation of parameters => 30% of STRUCTURE analyses could be reproduced
* software dependencies != static elements, but receive regular updates

--NEWV
Current approaches to solve barriers to adoption:

.1. *workflow software* (e.g. `make`), but:
  * no ownership and control of tools
  * cannot meet need of every researcher
  * standards-based => slower development

![galaxy](/images/galaxy.png) ![taverna](/images/taverna.png)

--NEWV

.2. *virtual machines*, but:
  * black box => bad for reproducibility
  * cannot be used as building block for downstream analysis

--NEWH
# :: How? ::

--NEWH
![docker logo](/images/docker-logo.png)

--NEWH
Docker = lightweight runtime and packaging tool built from existing components of the linux kernel

Docker = development workflow and ecosystem

--NEWV
Terminology:

* *image* = immutable description of a system
* *container* = running instance of an image

--NEWV
Possible uses:

* micro-services (e.g. neo4j)
* commands that return immediately (e.g. pandoc)
* interactive commands


--NEWH
**What does the system look like?**

--NEWV
Virtual machines vs docker

![vm-vs-docker](/images/vm-vs-docker.png)

--NEWV
Docker layers

![docker layers](/images/docker-layers.png)

--NEWV
"Union File System" across layers

![docker container layers](/images/container-layers-transparent.png)

--NEWV
Description of a docker image: `Dockerfile`

```sh
FROM neo4j:2.3
MAINTAINER Jan Aerts <jan.aerts@kuleuven.be>
EXPOSE 7474

RUN mkdir -p /startup
ADD docker-startup.sh /startup/docker-startup.sh
ADD gene-nodes.txt /startup/gene-nodes.txt
ADD disease-nodes.txt /startup/disease-nodes.txt
ADD gene-disease_relationships.txt /startup/gene-disease_relationships.txt
ADD gene-gene_relationships.txt /startup/gene-gene_relationships.txt
RUN chmod a+x /startup/docker-startup.sh

CMD ["/bin/sh", "/startup/docker-startup.sh"]
```

--NEWV
`Dockerfile` commands

* `FROM`: set the base image
* `RUN`: execute command in a new layer on top of the current image
* `ADD`: copy file from local directory into image
* `CMD`: default command to run when container is created
* ...

[https://docs.docker.com/engine/reference/builder/](https://docs.docker.com/engine/reference/builder/)

--NEWH
**Docker commands**

--NEWV
`docker build`

```
docker build --rm -t jandot/neo4j-i0u19a .
```

```sh
Sending build context to Docker daemon 15.25 MB
Step 1 : FROM neo4j:2.3
2.3: Pulling from library/neo4j
8b87079b7a06: Pull complete
a3ed95caeb02: Pull complete
1bb8eaf3d643: Pull complete
8b814800df49: Pull complete
8819a60acbef: Pull complete
1be1b08f002b: Pull complete
192853c43a20: Pull complete
9cebd99651f4: Pull complete
4e875535e701: Pull complete
beacf1089488: Pull complete
43ecb2670ec8: Pull complete
6de76c08a945: Pull complete
Digest: sha256:272442ce02990019a11690813f5e0853f5adea1c7b5177ab097c2427a019df4b
Status: Downloaded newer image for neo4j:2.3
 ---> c575eeb7b57a
Step 2 : MAINTAINER Jan Aerts <jan.aerts@kuleuven.be>
 ---> Running in 799f3182549f
 ---> b24b0c070ea9
Removing intermediate container 799f3182549f
Step 3 : ENV REFRESHED_AT 2016-04-28c
 ---> Running in 5d4de4045e58
 ---> 9a6420e72e12
Removing intermediate container 5d4de4045e58
Step 4 : RUN sed -i.bak 's/dbms.security.auth_enabled=true/dbms.security.auth_enabled=false/' /var/lib/neo4j/conf/neo4j-server.properties
 ---> Running in a9b8528faec2
 ---> a049c401d05f
Removing intermediate container a9b8528faec2
Step 5 : RUN echo "node_auto_indexing=true" >> /var/lib/neo4j/conf/neo4j.properties
 ---> Running in fc88f97b3d61
 ---> 76a4a3d5cd2a
Removing intermediate container fc88f97b3d61
Step 6 : RUN echo "node_keys_indexable=name" >> /var/lib/neo4j/conf/neo4j.properties
 ---> Running in 603e048350a5
 ---> a13f8e61e7c7
Removing intermediate container 603e048350a5
Step 7 : EXPOSE 7474
 ---> Running in d0068360cd10
 ---> 0df825b1bdb5
Removing intermediate container d0068360cd10
Step 8 : RUN mkdir -p /startup
 ---> Running in d39c6b15a1f0
 ---> 517816357a36
Removing intermediate container d39c6b15a1f0
Step 9 : ADD docker-startup.sh /startup/docker-startup.sh
 ---> fe9bad2e2888
Removing intermediate container 6bee721e9803
Step 10 : ADD gene-nodes.txt /startup/gene-nodes.txt
 ---> 9c75ced592fb
Removing intermediate container e7903156967a
Step 11 : ADD disease-nodes.txt /startup/disease-nodes.txt
 ---> 5cb3251688f9
Removing intermediate container 1db88ae5ed55
Step 12 : ADD gene-disease_relationships.txt /startup/gene-disease_relationships.txt
 ---> 95a20bbed0ca
Removing intermediate container eb9c7c836c7c
Step 13 : ADD gene-gene_relationships.txt /startup/gene-gene_relationships.txt
 ---> e55b8e4b14a7
Removing intermediate container 985a0dbc97b3
Step 14 : RUN chmod a+x /startup/docker-startup.sh
 ---> Running in 26dbdf8b9900
 ---> 716b2b18ded5
Removing intermediate container 26dbdf8b9900
Step 15 : CMD /bin/sh /startup/docker-startup.sh
 ---> Running in 27e70d127a39
 ---> 797c2cc5dfaa
Removing intermediate container 27e70d127a39
Successfully built 797c2cc5dfaa
```

--NEWV
`docker run`

```
docker run -d -p 7474:7474 jandot/neo4j-i0u19a
```

![neo4j screenshot](/images/neo4j-screenshot.png)

--NEWV
`docker exec`

```
docker exec -it <id> /bin/bash
```

to enter a running image

--NEWV
`docker push`

```
docker push jandot/neo4j-i0u19a
```

[hub.docker.com](http://hub.docker.com)

![dockerhub screenshot](/images/dockerhub-screenshot.png)

--NEWH
**How to build a `Dockerfile`?**

--NEWV
.1. Start from a base image `Dockerfile`
```
FROM jupyter/datascience-notebook
```

(see https://hub.docker.com/r/ipython/notebook/)

--NEWV
.2. Build and run the base image

```
docker build -t ipython-dev-env .
docker run -it --rm -p 8888:8888 ipython-dev-env
```

Navigate to http://localhost:443

--NEWV
.3. Install an extra python module into the notebook server

```
!pip3 search gensim
!pip3 install gensim
```

.4. See if it works

```
import gensim
```

--NEWV
.5. If it works: add command to `Dockerfile`

```
FROM jupyter/datascience-notebook
RUN pip3 install gensim
```

.6. Rebuild and re-run

--NEWH
**Installing docker**

* linux: through official packages
* OSX & Windows: need lightweight VM => boot2docker or beta

--NEWH
**How does this solve the challenges?**

* dependency hell
* imprecise documentation
* code rot
* barriers to adoption and reuse in existing solutions

--NEWV
Dependency hell

* docker images

--NEWV
Imprecise documentation

* `Dockerfile`

--NEWV
Code rot

* docker image versions

```
docker build --rm -t jandot/neo4j-i0u19a .
```
vs
```
docker build --rm -t jandot/neo4j-i0u19a:1.0 .
```

--NEWV
Barriers to adoption and reuse

* build once, run everywhere (on student's laptop, ...)
* integrating into local development environments
* portable computation & sharing
* re-usable modules
* versioning
* fast

--NEWH
**Complete applications**

--NEWV
`docker-compose.yml`

```
mongo:
  image: mongo:2.6.11
  ports:
   - "27017:27017"
application:
  build: .
  command:  node --debug=5858 app.js --color=always
  ports:
   - "3000:3000"
   - "5858:5858"
  volumes :
  - ./:/app
  links:
   - mongo
```

--NEWV
[panamax.io](http://panamax.io)

![panamax](/images/panamax.png)

--NEWH
**Deploying applications on cluster**

--NEWV
Docker Swarm

[www.docker.com/products/docker-swarm](https://www.docker.com/products/docker-swarm)

![docker-swarm](/images/docker-swarm.png)

* [Evaluate Swarm in a sandbox](https://docs.docker.com/swarm/install-w-machine/)
* [Try Swarm at scale](https://docs.docker.com/swarm/swarm_at_scale/)

--NEWV
Kubernetes

[kubernetes.io](http://kubernetes.io/)

![kubernetes](/images/kubernetes.png)

* [Getting started](http://kubernetes.io/docs/getting-started-guides/)
* Turn-key cloud solutions on [Google Compute Engine](http://kubernetes.io/docs/getting-started-guides/gce/), [AWS](http://kubernetes.io/docs/getting-started-guides/aws/), [Azure](http://kubernetes.io/docs/getting-started-guides/coreos/azure/)

--NEWH
**Best practices**

--NEWV
Use docker containers during development

Write `Dockerfile`s instead of installing interactive sessions

Add tests or checks to the `Dockerfile`

Use and provide appropriate base images

Version everything in the `Dockerfile`

Note:

1 Dockerfile with all software dependencies that you normally use as base image

--NEWV
```
FROM jupyter/pyspark-notebook:latest
MAINTAINER Jan Aerts <jan.aerts@kuleuven.be>
RUN pip install pymongo
RUN pip install py2neo
RUN pip install bokeh
...
```
vs
```
FROM jupyter/pyspark-notebook:2d878db5cbff
MAINTAINER Jan Aerts <jan.aerts@kuleuven.be>
RUN pip install pymongo==3.2.2
RUN pip install py2neo==2.0.8
RUN pip install bokeh==0.11.1
...
```

--NEWH
# :: What? ::

Demo

--NEWV
neo4j

--NEWV
```
docker run -d -p 7474:7474 jandot/neo4j-i0u19a
```

![neo4j screenshot](/images/neo4j-screenshot.png)

--NEWV
pandoc

--NEWV
`my-text.md`

```markdown
This post is part of a collection for our students in "Managing Large
Omics Datasets" (I0U19A) at the KU Leuven. In this exercise, we will
perform queries on a MongoDB database that has been populated with
the beer dataset.

## Preparation
As with the Hadoop exercises, we’ll use Docker containers. See [this
blog post with the hadoop exercise](http://vda-lab.github.io/2016/04/hadoop-tutorial)
for a refresher.

To run, type `docker run -d -p 27017:27017 jandot/mongo-i0u19a`, and
then:

* if you have the mongo client locally: `mongo --host 192.168.99.100`
* if you don't: `docker run -it --rm jandot/mongo-i0u19a /bin/bash`,
and then `mongo --host 192.168.99.100`

...
```

--NEWV
```
docker run -v $(pwd):/source jandot/pandoc -f markdown -t latex /source/my-text.md -o /source/my-text.pdf
```

![pandoc-output](/images/pandoc-output.png)

--NEWV
jupyter and neo4j

--NEWV
```
docker run -d -p 7474:7474 jandot/neo4j-i0u19a
docker run -d -p 8888:8888 jandot/jupyter-i0u19a
```

--NEWV
This presentation...

--NEWV
`slides/slides.md`

```
 --NEWH
Docker container =~ light-weight virtual machine

*image* = immutable description of a system

*container* = running instance of an image

 --NEWV
Possible uses:

* micro-services (e.g. neo4j)
* commands that return immediately (e.g. pandoc)
* not: interactive commands

Using both neo4j and mongodb in the same application?
...
```

--NEWV
Viewing the presentation
```
docker run \
	-p 8000:8000 \
	-v $(pwd)/images:/opt/presentation/images \
	-v $(pwd)/slides:/opt/presentation/slides \
	-d jandot/docker-presentation
```

--NEWH
Bioinformatics-specific examples:

* RNA sequencing pipeline: [www.nextflow.io/example4.html](http://www.nextflow.io/example4.html)
* [Biodocker.org](http://biodocker.org/): BLAST, EMBOSS, bwa, picard, samtools, vcftools, ...
* [Algorun - Docker-based container template for computational algorithms](http://algorun.org)
* RStudio: `docker run -d -p 8787:8787 rocker/rstudio` => [localhost:8787](http://localhost:8787) (`rstudio`/`rstudio`)

--NEWH
More information

[docker.io](http://docker.io)

[docs.docker.com](http://docs.docker.com)

[hub.docker.com](http://hub.docker.com)

--NEWH
# :: Exercises ::

![cowsay](images/cowsay.png)

--NEWV
To create the cow image, you'll need to have the <u>`fortune`</u> and <u>`cowsay`</u> commands installed on an <u>ubuntu</u> system.

--NEWV
Exercises:
1. Running an image interactively
1. Running an image with default behaviour
1. Adding customizable quote at build stage
1. Adding customizable quote at run stage

--NEWH
## 1. Running an image interactively
* Start an interactive ubuntu docker image: `docker run -it --rm ubuntu /bin/bash`
  * What does each parameter mean?
* Update the software packages: `apt-get update`
* Install `fortune`: `apt-get install fortune`
* Install `cowsay`: `apt-get install cowsay`
* Try it out: `/usr/games/fortune | /usr/games/cowsay`
* When done, type `exit`

What do you need to do if you want to do this again?

--NEWH
## 2. Running an image with default behaviour:<br/>Let the cow say a random adage
If you want to generate a new image: need to run an ubuntu image again, install `fortune` and `cowsay`, and run the command.

Better: create specific image based on Dockerfile

Reference: see https://docs.docker.com/engine/reference/builder/

--NEWV
Steps:
* Create `Dockerfile` file
* Build docker images
* Run docker container

--NEWV
Dockerfile

```
FROM ubuntu:14.04
MAINTAINER YourName <youremail>

#Get up-to-date
RUN apt-get update && apt-get upgrade -y

#Install fortune and cowsay
RUN apt-get install -y fortune cowsay

#Set the default command
CMD /usr/games/fortune | /usr/games/cowsay
```

--NEWV
Build and run:
```
docker build -t <yourname>/exercise2 .
docker run <yourname>/exercise2
```

--NEWH
## 3. Adding customizable quote at build stage:<br/>Let the cow say anything you provide
What if we want to tell the cow exactly what to say, instead of relying on `fortune`?

Create file `my-saying.txt` that contains our message.

--NEWV
Dockerfile

```
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
```

--NEWV
Problem: changing contents of `my-saying.txt` is not reflected in what cow says, unless we rebuild the image

--NEWH
### 4. Adding customizable quote at run stage:<br/>Let the cow say anything you provide
New approach: _mount_ local directory

--NEWV
Dockerfile

```
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
```

--NEWV
* `docker build -t <yourname>/exercise4 .`
* ``docker run -v `pwd`:/work <yourname>/exercise4``