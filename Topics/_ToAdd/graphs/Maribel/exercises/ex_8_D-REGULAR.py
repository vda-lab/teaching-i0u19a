import networkx as nx

#   We generate a random 100 node graph

net=nx.fast_gnp_random_graph(20,0.4)

#------------------------------------

#   Now we wonder: Is "net" a regular graph?, that means that all pair of nodes has the same distance as any other.

#   the function "is_distance_regular()" answers this question as TRUE or FALSE 

print("Is net distance regular? \n",nx.is_distance_regular(net),"\n")
