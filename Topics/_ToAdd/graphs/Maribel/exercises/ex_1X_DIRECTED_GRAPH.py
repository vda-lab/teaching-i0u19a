import networkx as nx 
import matplotlib.pyplot as plt 


# G=nx.random_geometric_graph(100,0.25)
# nx.draw(G,with_labels=True)

# plt.show()


def draw_graph(graph):

	#Extract nodes from graph

	#create network graph
	G=nx.DiGraph(graph)

	#draw graph
	pos=nx.shell_layout(G)  #Nodes in concentric circles
	nx.draw(G,pos,with_labels=True)
	plt.show()


	#1 Definition in degree
	in_degrees=G.in_degree()   
	print('In degree', in_degrees)

	
	out_degrees=G.out_degree()
	print('Out degree', out_degrees)

	#2 umber of connection for undirected graphs
	#Definiton of the undirected version
	U=G.to_undirected()
	pos=nx.shell_layout(U)
	nx.draw(U,pos,with_labels=True)
	n_connections=sum(in_degrees)+sum(out_degrees)
	print ('number of connections', n_connections)


	#3 Definition of Neighbors
	node=3      #Choose the node you want to know its neighbors
	neigh=G.neighbors(node)   #Return a list of the nodes connected with the node called node
	print(r'Neighbors of node %0.0f'%node,neigh)  #Format for including float values in the string. f stands for float

	
	#4 Plot de Degree Frequency and Degree Distribution
	in_values=sorted(set(in_degrees.values()))   #order the degree of the nodes without repetitions by using set
	in_hist=[in_degrees.values().count(x) for x in in_values] #take the number of repetition of degreee x, this counts the number of nodes with degree x.
	in_hist_dis=[float(in_degrees.values().count(x))/(G.order()) for x in in_values]  #degree distribution


	out_values=sorted(set(out_degrees.values()))   #order the degree of the nodes without repetitions by using set
	out_hist=[out_degrees.values().count(x) for x in out_values] #take the number of repetition of degreee x, this counts the number of nodes with degree x.
	out_hist_dis=[float(out_degrees.values().count(x))/(G.order()) for x in out_values] 

	plt.figure()
	plt.plot(in_values,in_hist,'ro-',label='In degree frequency')
	plt.plot(out_values,out_hist,'bv-',label='Out degree frequency')
	plt.legend(['Degree'])
	plt.xlabel('Degree')
	plt.ylabel('Number of nodes')
	plt.title('Degree Frequency')
	plt.legend(loc='best')
	#plt.savefig('Degree_Frequency.pdf') #Saving plot in a pdf file
	#plt.close()

	plt.figure()
	plt.plot(in_values,in_hist_dis,'ro-',label='In degree distribution')
	plt.plot(out_values,out_hist_dis,'bv-',label='Out degree distribution')
	plt.legend(['Degree'])
	plt.xlabel('Degree')
	plt.ylabel('Number of nodes')
	plt.title('Degree Distribution')
	plt.legend(loc='best')
	#plt.savefig('Degree_Frequency.pdf') #Saving plot in a pdf file
	#plt.close()



	#show graph
	plt.show()

	return G

g=[(0,1),(0,2),(0,3),(1,2),(1,5),(2,3),(2,5),(3,4),(3,5),(4,6),(5,6),(5,7),(5,8),(5,9),(5,10),(6,7),(6,9),(8,9),(8,10),(8,11),(11,12)]

draw_graph(g)


	


