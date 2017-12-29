# See https://github.com/jupyter/docker-stacks
# VERSION 3:
# - Spark
# - mongo
# - neo4j
FROM jupyter/pyspark-notebook:2d878db5cbff
MAINTAINER Jan Aerts <jan.aerts@kuleuven.be>
ENV REFRESHED_AT 2016-05-11c

USER root

RUN pip install pymongo==3.2.2
RUN pip install py2neo==2.0.8
RUN pip install bokeh==0.11.1

ADD spark_exercises.ipynb spark_exercises.ipynb
ADD mongo_exercises.ipynb mongo_exercises.ipynb
ADD neo4j_exercises.ipynb neo4j_exercises.ipynb
ADD images/screenshot_browser.png images/screenshot_browser.png
ADD images/small_network.png images/small_network.png
