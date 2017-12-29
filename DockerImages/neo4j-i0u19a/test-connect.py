#!/usr/bin/env python
from py2neo import Graph, Node, Relationship
secure_graph = Graph("http://neo4j:neo4j@192.168.99.100:7474/db/data/")
alice = Node("Person", name="Alice")
secure_graph.create(alice)
