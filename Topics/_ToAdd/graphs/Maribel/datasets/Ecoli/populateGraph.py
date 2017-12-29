import sys
import networkx as nx

REGULATORY=sys.argv[1]

I=nx.DiGraph()

for line in open(REGULATORY, 'r'):
    splitLine=line.split()
    gene1=splitLine[0].lower()
    gene2=splitLine[1].lower()
    I.add_edge(gene1, gene2)

print(I.edges())
   
