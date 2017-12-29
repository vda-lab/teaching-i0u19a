
     ##########################################################################
     #                                                                        #
     #                    GRAPHS AND BIOLOGICAL NETWORKS                      #
     #                                                                        #
     #   > Ex_1: Create a simple graph.                                       #
     #                                                                        #
     ##########################################################################

# DESCRIPTION: Create a graph using the NetworkX library in Python language... 

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

#########################################  END ###################################################


