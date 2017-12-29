import networkx as nx
import matplotlib.pyplot as plt

G=nx.random_geometric_graph(100,0.125)

#pos=nx.shell_layout(G)   ##Position nodes in concentric circles
nx.draw(G,with_labels=True)

# Betweenness centrality
bet_cen = nx.betweenness_centrality(G)  #Dictionary of betweenness centrality

# degree centrality
deg_cen = nx.degree_centrality(G)     #Dictionary of degree centrality

# # Eigenvector centrality
# eig_cen = nx.eigenvector_centrality(hartford_mc)


def highest_centrality(cent_dict):
	"""Returns a tuple (node,value) with the node
	with largest value from Networkx centrality dictionary."""
	# Create ordered tuple of centrality data
	cent_items=[(b,a) for (a,b) in cent_dict.iteritems()]
	# Sort in descending order
	cent_items.sort()
	cent_items.reverse()
	return tuple(reversed(cent_items[0]))


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


highest_centrality(bet_cen)
highest_centrality(deg_cen)
centrality_scatter(bet_cen,deg_cen)
