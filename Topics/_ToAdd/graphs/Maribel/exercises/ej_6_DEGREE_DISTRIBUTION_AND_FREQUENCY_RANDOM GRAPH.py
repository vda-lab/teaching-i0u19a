import networkx as nx
import matplotlib.pyplot as plt
def draw_graph(graph):

	#extract nodes from graph
	nodes=set([n1 for n1,n2 in graph]+[n2 for n1,n2 in graph])


	#create networkx graph
	G=nx.Graph()

	#add nodes

	for node in nodes:
		G.add_node(node)

	#add edges
	for edge in graph:
		G.add_edge(edge[0],edge[1])

	#draw graph
	pos=nx.shell_layout(G)
	nx.draw(G,pos)


	v_degree=G.degree()   #Dictionary node
	print(v_degree)


	#show graph
	plt.show()
	return v_degree

def degree(graph):
	#extract nodes from graph
	nodes=set([n1 for n1,n2 in graph]+[n2 for n1,n2 in graph])


	#create networkx graph
	G=nx.Graph()

	#add nodes

	for node in nodes:
		G.add_node(node)

	#add edges
	for edge in graph:
		G.add_edge(edge[0],edge[1])

	v_degree=G.degree()

	return v_degree


def draw_histogram(degree):
	v_degree=degree

	values=sorted(set(v_degree.values()))


	print(values)

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

g=[(0,1),(0,2),(0,3),(1,2),(1,5),(2,3),(2,5),(3,4),(3,5),(4,6),(5,6),(6,7)]

draw_graph(g)
draw_histogram(degree(g))


# for node in g.nodes():
#   	print (node, g.degree(node))