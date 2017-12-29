import networkx as nx
import matplotlib.pyplot as plt


#Define a function for creating and plotting a Digraph

def draw_graph(graph):
	G=nx.DiGraph(graph)
	pos=nx.shell_layout(G)
	nx.draw(G,pos,with_labels=True)
	return G

#g=[(0,1),(0,2),(0,3),(1,2),(1,5),(2,3),(2,5),(3,4),(3,5),(4,6),(5,6),(6,7)]
g=[(1,2),(1,5),(1,7),(2,3),(2,6),(3,4),(4,5),(4,6),(4,7),(4,8),(4,9),(5,6),(5,7),(7,9)]



G=draw_graph(g)     #Get the graph obtained in the function draw_graph
#g_mc = G[0]
# Betweenness centrality
bet_cen = nx.betweenness_centrality(G)

# degree centrality
deg_cen = nx.degree_centrality(G)
# # Eigenvector centrality
# eig_cen = nx.eigenvectoceantrality for r_centrality(hartford_mc)


def highest_centrality(cent_dict):
	"""Returns a tuple (node,value) with the node
	with largest value from Networkx centrality dictionary."""
	# Create ordered tuple of centrality data
	cent_items=[(b,a) for (a,b) in cent_dict.iteritems()]
	# Sort in descending order
	cent_items.sort()
	cent_items.reverse()
	return tuple(reversed(cent_items[0]))


#Show a scatter plot to compare two types of centrality
def centrality_scatter(dict1,dict2,path="",
	ylab="",xlab="",title="",line=False):
	# Create figure and drawing axis
	fig = plt.figure(figsize=(7,7))
	ax1 = fig.add_subplot(111)
	# Create items and extract centralities

	items1 = sorted(dict1.items())
	items2 = sorted(dict2.items())
	xdata=[b for a,b in items1]
	ydata=[b for a,b in items2]

	# Add each actor to the plot by ID
	for p in xrange(len(items1)):
		ax1.text(x=xdata[p], y=ydata[p],s=str(items1[p][0]), color="b")
	if line:
		# use NumPy to calculate the best fit
		slope, yint = plt.polyfit(xdata,ydata,1)
		xline = plt.xticks()[0]
		yline = map(lambda x: slope*x+yint,xline)
		ax1.plot(xline,yline,ls='--',color='b')
	# Set new x- and y-axis limits
	plt.xlim((0.0,max(xdata)+(.15*max(xdata))))
	plt.ylim((0.0,max(ydata)+(.15*max(ydata))))
	# Add labels and save
	ax1.set_title('Centrality Scatter')
	ax1.set_xlabel('Betweenness centrality')
	ax1.set_ylabel('Degree centrality')
	plt.show()
	#plt.savefig(path)


hcBetweenness=highest_centrality(bet_cen)
print('Highest Betweenness centrality',hcBetweenness)

hcDegree=highest_centrality(deg_cen)
print('Highest Degree centrality',hcDegree)

centrality_scatter(bet_cen,deg_cen)
