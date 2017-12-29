     ##########################################################################
     #                                                                        #
     #                    GRAPHS AND BIOLOGICAL NETWORKS                      #
     #                                                                        #
     #   > Ex_4: Degrees and releated properties.                             #
     #                                                                        #
     ##########################################################################

# DESCRIPTION: Analize some graph properties dependent of the degree of each node using the network
#             of EX_1...

##################################################################################################

# I. Call Library:
import networkx as nx

    
# II. Create a Simple Graph object:
G = nx.Graph()
 


# III. Add some nodes (9) to the Graph:
G.add_node(1)
G.add_node(2)
G.add_node(3)
G.add_node(4)
G.add_node(5)
G.add_node(6)
G.add_node(7)
G.add_node(8)
G.add_node(9)



# IV. Add some edges (14) between nodes in the Graph, let some of these be weighted:
G.add_edge(1, 2, weight = 12)
G.add_edge(1, 7)
G.add_edge(2, 3)
G.add_edge(3, 4, weight = 5)
G.add_edge(4, 5)
G.add_edge(4, 6, weight = 2)
G.add_edge(4, 7)
G.add_edge(4, 8)
G.add_edge(4, 9)
G.add_edge(5, 1, weight = 7)
G.add_edge(5, 6, weight = 13)
G.add_edge(5, 7, weight = 4)
G.add_edge(6, 2)
G.add_edge(9, 7)



# V. Ask for the degree of each node by two different methods:

# V. Library Function
print("\n\n")
print("- Degree of each node by library function:\n")
for c in range(1, G.order() + 1):
    print("d (", c,") = ", G.degree(c))

# V. Length of Neighborhood:
print("\n\n")
print("- Degree of each node by neighborhood length:\n")
for c in range(1, G.order() + 1):
    print("Neighborhood of node", c,":", G.neighbors(c), "\n> d (", c, ") = ", len(G.neighbors(c)))
print("\n")



# VI. Sequence Degree:

# VI.1 Arrange Degrees
SD = []
for c in range(1, G.order() + 1):
    SD.append(G.degree(c))

# VI.2 Sort the Sequence Degree: 
SD.sort()
print("- SEQUENCE DEGREE:\n", SD, "\n")



# VII. Average degree:
av_d = 0
for c in range(len(SD)):
    av_d = av_d + SD[c]
av_d = av_d / (G.order())
print("- Average Degree for every node:\n", av_d, "\n")



# VIII. Maximum Degree:
print("- Maximum Degree for every node:\n", (G.order() - 1), "\n")



# IX. Maximum number of edges:
print("- Maximum number of possible edges in the graph:\n", (G.order()*(G.order() - 1)/2), "\n")



# X. Density or Connectance by two different methods:

# X.1 By Average Degree over Maximum Degree:
print("- Density or Connectance (Average Degree / Maximum Degree):\n")
print((av_d / (G.order() - 1)), "->", (av_d  * 100/ (G.order() - 1)), "%\n")

# X.2 By Number of existing edges over possible edges:
print("- Density or Connectance (Existing Edges / Possible Edges):\n")
print(G.size() / (G.order()*(G.order() - 1)/2), "->", G.size()*100/ (G.order()*(G.order() - 1)/2), "%\n")

#########################################  END ###################################################
