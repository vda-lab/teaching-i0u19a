import networkx as nx

#   We generate a random 100 node graph

net=nx.fast_gnp_random_graph(20,0.4)

#------------------------------------

#   And now we are getting the shrotest paths for a given pair of nodes. In this case we choose 13 and 19

ShortestPaths=list(nx.all_shortest_paths(net,13,19))
print("Shortest Paths: \n",ShortestPaths,"\n")

#   But we can also obtain only one of them:

ShortestPath=list(nx.shortest_path(net,13,19))
print("One of the shortest path= ",ShortestPath,"\n")

#-------------------------------------

#   We can also ask us: Is the graph connected?
#   And the cfunction "is_connected" can answer that question

print("Is the graph connected? \n",nx.is_connected(net),"\n")
#-------------------------------------
