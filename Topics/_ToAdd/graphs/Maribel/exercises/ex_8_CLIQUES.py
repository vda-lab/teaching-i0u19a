import networkx as nx

#   We generate a random 100 node graph

net=nx.fast_gnp_random_graph(20,0.4)

#------------------------------------

#   A Clique is a subset of nodes in the graph that are completly conected between each other.

#   The function "nx.enumerate_all_cliques(net)" returns an object containing al the cliques possible in a graph.

#   we use the list command in order to obtain a listable object

NetCliques=list(nx.enumerate_all_cliques(net))
print("NetCliques[15:30]: \n",NetCliques[15:30],"\n")

#   we can also get a list of the maximum cliques for each set of nodes

NetCliques=list(nx.find_cliques(net))
print("NetCliques[15:30]: \n",NetCliques[15:30],"\n")

#   we can also obtain the size of the largest clique

lengthClique=nx.graph_clique_number(net)
print("length Clique= ",lengthClique,"\n")

#   We can get the amount of maximal cliques

nodesNum=nx.graph_number_of_cliques(net)
print("graph number of cliques= ",nodesNum,"\n")

#   We can also obtain the size of the maximal clique for a given node, in this case the node 13 

nodeCliqueNumber=nx.node_clique_number(net,13)
print("size node Clique= ",nodeCliqueNumber,"\n")

#   And we can obtain the number ob cliques that contain a given node

nodeNumberCliques=nx.number_of_cliques(net,13)
print("number of cliques in a node= ",nodeNumberCliques,"\n")

#   And at last we are able to list those cliques containing node 13

CliquesWhitNode=nx.cliques_containing_node(net,13)
print("cliques whit node 13: \n",CliquesWhitNode,"\n")

#-------------------------------------

#   An independent set contains nodes that are not adjacet to each other. That is a fancy way to say that is a subset of nodes that are not connected in the original graph

IndependentSets=nx.maximal_independent_set(net)
print("Independent Sets: \n",IndependentSets,"\n")

#-------------------------------------

