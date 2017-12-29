#!/bin/sh
/var/lib/neo4j/bin/neo4j-import --into data/graph.db --nodes /startup/gene-nodes.txt --nodes /startup/disease-nodes.txt --relationships /startup/gene-gene_relationships.txt --relationships /startup/gene-disease_relationships.txt
/docker-entrypoint.sh neo4j
