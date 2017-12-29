#! /usr/bin/env python3
##########################################################################\
#Graph diameter and distance between vertices using NetworkX module\
##########################################################################\
#Andrés García García, 2/Feb/2016

#Printing the title...
print("\n##########################################################################\n\
#Graph diameter and distance between vertices using NetworkX module\n\
##########################################################################\n")

#First we import NetworkX module, we import it as nx to make writing easy
import networkx as nx


#We declare a graph G:
G=nx.Graph()
G.add_edges_from([(1,3),(3,5),(2,4),(6,8),(2,7),(1,7),(7,3),(2,6),(2,1),(4,7)])
#Printing the graph...
print("\nNow we declare a graph G.")
print( "Nodes:\t" + str(G.nodes()) )
print( "Edges:\t" + str(G.edges()) )

#............................................................................
#CALCULATION OF THE GRAPH's DIAMETER
print("\n........................................................")
print("CALCULATION OF THE GRAPH'S DIAMETER")
#For this we use NetworkX's function diameter()
Diameter=nx.diameter(G)
#Printing the result...
print("G's diameter is: " + str(Diameter))

#............................................................................
#CALCULATION OF THE DISTANCES BETWEEN EACH NODE PAIR
print("\n........................................................")
print("CALCULATION OF THE DISTANCES BETWEEN EACH NODE PAIR")
#We know the distance between two nodes is the length of the shortest path between both...
#...And for this wu use NetworkX's function shortest_path_length()
Distances=nx.shortest_path_length(G)
#This function returns a dictionary object such that Distances[edge1][edge2] is the distance between edge1 and edge2
#Printing the result...
print("The dictionary object with the distances between each pair is:")
for key in Distances.keys():
	print(str(key) + ":\t" + str(Distances[key]))
print("Using this we can see the distance between edge 5 and edge 8 is: " + str(Distances[5][8]))
print("and the distance between 1 and 4 is: " + str(Distances[1][4]))