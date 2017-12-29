     ##########################################################################
     #                                                                        #
     #                    GRAPHS AND BIOLOGICAL NETWORKS                      #
     #                                                                        #
     #   > Ex_2: Properties of a graph , complement, subgraph and drawing.    #
     #                                                                        #
     ##########################################################################

# DESCRIPTION: Analize some properties of the graph from EX_1, generate its complement, subgraphs,
#              and draw these with the NetworkX functions and the Matplotlib library... 

##################################################################################################

# I. Call Library:
import networkx as nx
import matplotlib.pyplot as plt


    
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



# V. Some properties of the graph:

# V.1 Print Introduction:
print("\n\n         > GRAPH DESCRIPTION <\n")

# V.2 Number of nodes:
print("- The graph order (number of nodes) is:\n", G.order(), "\n")

# V.3 List of nodes:
print("- The nodes in the graph are named:\n", G.nodes(), "\n")

# V.4 Number of edges:
print("- The graph size (number of edges) is:\n", G.size(), "\n")

# V.5 List of edges:
print("- The edges in the graph form this set of pairs of nodes:\n", G.edges(), "\n")

# V.6 Neighborhoods without weights:
print("- Neighborhoods without weights:\n")
for c in range (1, G.order() + 1):
    print("Neighborhood of node", c, ": ", G.neighbors(c))
print("\n")

# V.7 Neighborhoods with weights:
print("- Neighborhoods with weights:\n")
for c in range (1, G.order() + 1):
    print("Neighborhood of node", c, ": ", G[c])
print("\n")

# V.8 Ask for edges atributes:
print("- HOW TO ASK FOR EDGES INFO (WARNING! DONT ASK FOR UNDEFINED EDGES):\nG[1][2] ->", G[1][2], "\n")
print("\n\n")

# VI. Draw the graph in background with NetworkX and then display it with matplotlib: 
nx.draw(G, with_labels = True)
plt.show()

# VII. Create its complement and draw it:
H = nx.complement(G)
nx.draw(H, with_labels = True)
plt.show()



# VIII. Look for some specific subgraphs and draw them (induced subgraph):

# VIII.1 First example; Cycle of 5 nodes:
C_5 = G.subgraph([1, 2, 3, 4, 5])
nx.draw(C_5, with_labels = True)
plt.show()

# VIII.2 Second example; Path of 4 nodes
P_4 = G.subgraph([1, 2, 3, 4])
nx.draw(P_4, with_labels = True)
plt.show()

#########################################  END ###################################################
