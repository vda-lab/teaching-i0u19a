     ##########################################################################
     #                                                                        #
     #                    GRAPHS AND BIOLOGICAL NETWORKS                      #
     #                                                                        #
     #   > Ex_3: Adjacency Matrix and Adjacency List of a Simple Graph        #
     #                                                                        #
     ##########################################################################

# DESCRIPTION: Generate the Matrix and List representation of the SIMPLE graph from EX_1...

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



# V. Adjacency Matrix without weights:
A = nx.adjacency_matrix(G, weight = None)
A = A.toarray()
print("\n\n")
print("- Adjacency Matrix without weights:\n")
for c in range(G.order()):
    print(c + 1, " ", end = "")
print("\n--------------------------")
for i in range(G.order()):
    for j in range(G.order()):
        print(A[i][j], " ",  end = "")
    print(" | ", i + 1)



# VI. Adjacency Matrix with weights:
A = nx.adjacency_matrix(G)
A = A.toarray()
print("\n\n")
print("- Adjacency Matrix with weights:\n")
for c in range(G.order()):
    print(c + 1, "\t", end = "")
print("\n---------------------------------------------------------------------------------")
for i in range(G.order()):
    for j in range(G.order()):
        print(A[i][j], "\t",  end = "")
    print("\t| ", i + 1)



# VII. Adjacency List by two different methods:

# VII.1 Library Function:
print("\n\n")
print("- Adjacency List (Library Function):\n")
print(G.adj)

# VII.2 By neighborhoods:
print("\n\n")
print("- Adjacency List (By neighborhoods):\n")
for c in range(1, G.order() + 1):
    print(c, " | ", G.neighbors(c))
print("\n\n")



# VIII. Draw the graph to compare it with the other forms:
nx.draw(G, with_labels = True)
plt.show()

#########################################  END ###################################################
