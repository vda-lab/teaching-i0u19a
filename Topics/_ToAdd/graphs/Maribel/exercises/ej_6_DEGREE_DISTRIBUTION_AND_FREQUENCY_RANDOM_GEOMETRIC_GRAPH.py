import networkx as nx
import matplotlib.pyplot as plt
def draw_graph(graph):

	nx.draw(graph,with_labels=True)
	plt.show()



def draw_histogram(graph):
	G=graph
	v_degree=G.degree()

	values=sorted(set(v_degree.values()))

	hist=[v_degree.values().count(x) for x in values] 
	hist_distribution=[float(v_degree.values().count(x))/(G.order()) for x in values]

	plt.figure()
	plt.plot(values,hist,'ro-')   #Degree frequency
	plt.legend(['Degree'])
	plt.xlabel('Degree')
	plt.ylabel('Number of nodes')
	plt.title('Degree Frequency')
	#plt.savefig('Degree_Distribution.pdf')
	#plt.close()

	plt.figure()
	plt.plot(values,hist_distribution,'bv-')   #Degree distribution
	plt.legend(['Degree'])
	plt.xlabel('Degree')
	plt.ylabel('Number of Nodes of degree x/ order of the graph')
	plt.title('Degree distribution')
	#plt.savefig('Degree_Distribution.pdf')
	#plt.close()


	#show graph
	plt.show()


#draw example

g=nx.random_geometric_graph(100,0.25)

draw_graph(g)
draw_histogram(g)


# for node in g.nodes():
#   	print (node, g.degree(node))