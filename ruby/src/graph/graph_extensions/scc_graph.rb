require_relative "../graph"

#strongly_connected_component
########################################################################################################################
#In the mathematical theory of directed graphs, a graph is said to be strongly connected
# if every vertex is reachable from every other vertex.
# The strongly connected components of an arbitrary directed graph form a partition
# into sub-graphs that are themselves strongly connected.
# It is possible to test the strong connectivity of a graph,
# or to find its strongly connected components, in linear time.
#
#In this class there are two function that calculate strongly connected components in graph
# :scc_dsf() and :scc_graph() the different is that
# scc_dsf: based on current graph object and
#          use specially "c" field on vertexes to mark its membership in concrete component
#          scc_dsf is not only is shorter to implement, but in practice
#          turns out to be faster, because of no necessity of constructing a graph of the resulting
#          therefore, if the result is determined by it enough, do not use the scc_graph if You don't
#          need additional graph object
# scc_graph: The function in addition to determining the values ​​of the variables "c", as a result of your actions
#          returns in addition graph strongly coherent components. The vertices of the graph are numbered
#          topologically in the order (from the top of a larger number does not lead edge
#          to the tip of a number less), which is a very useful property of the solve many problems.
#
# The time complexity of both of the following functions is linear, because of the size of the input graph (O (n + m)).
# This is due to the fact that both functions are performed twice with the modified DFS algorithm.
########################################################################################################################
class SccsGraph < Graph

  #Extend vertices by an additional array "l" of ancestors
  def initialize (number_of_nodes, component=nil)
    super number_of_nodes, component == nil ?  Component : component
    @vis = Array.new
    @scc_res = nil ##Graph.new(number_of_nodes, Component)
  end

##
#Function passing graph for the help of the DFS algorithm.
# It is used twice: in the first phase when determining the order of vertices for the second phase,
# then during the second phase to determine the strongly consistent component and then
# construction graph of strongly consistent components
#
# * *Args*    :
#   - +v+ ->  source vertex from we start
#   - +nr+ ->  source graph for with we run sccs
#   - +phase+ -> as bool value: true for 1 phase, false for second phase
# * *Return*    :   nil, but update graph structure
##
def scc_dsf(v, nr, first_phase)
  #Mark vertex as visited
  g[v].c = 1
  #If the second phase is executed searches, then set the vertex number of strongly connected components
  if not first_phase then vis[v]=nr end
  #Visit consecutive vertices,
  # and (if the second phase is executed) add Edge to the constructed graph strongly consistent component
  g[v].each do |it|
    if it.c == -1
      scc_dsf(it.v, nr, first_phase)
    elsif (!first_phase and nr > @vis[it.v] )
      @scc_res.add_edge_d(g[it.v].c, vis[it.v]=nr);
    end
  end #each

  #If the first phase is executed, insert a vertex to the list,
  # or if the second update its time
  if first_phase then vis.push(v); else g[v].c = nr; end

end

##
#Function defining strongly connected components in a graph and return it as result
# * *Args*    :  nil
# * *Return*    :  result is a constructed strongly consistent component graph
##
def scc_graph()
  #Graf "gt" is a graph transposed, and "res" is constructed graph strongly consistent component
  gt = SccsGraph.new(g.size, Component);  res = SccsGraph.new(g.size, Component)
  tab = [self, gt]
  #prepare "gt"
  gt.scc_res=res; gt.vis = Array.new(g.size){-1}; vis.clear;

  #Building a transposed graph
  for i in 0..g.size
    g.each do |it|
      gt.add_edge_d(it.v, i)
    end
  end

  #perform two phases of algorithm dfs :
  [0, 1].each_with_index do |i, index|
    #mark vertexes as unvisited
    tab[i].g.each do |v| v.c = -1 end
    comp = 0; v = 0;

    #for subsequent vertexes make searching
    for j in g.size-1..0

      i==1 ? v=vis[j] : j
      #if vertex is without component
      if tab[i].g[v].c == -1
        is_first_phase = (1-i != 0)
        tab[i].scc_dsf(v, comp, is_first_phase)
      end
    end

    if i==1 then res.g = Array.new(comp) end

  end

  for i in 0..g.size do g[i].c = gt.g[i].c end

  return res
end

##
#Write each strongly connected components from self graph
# In first column write number of component then in second col vertexes that
# belongs to this component
#
# Output - <ComponentNumber> : <List of vertices belonging,..>
#           ..               : ..
#           ...
def write_scc
    g.group_by{|v| v.c}.values.each{|component| print "#{component.first.c} : "; component.each{|vertex| print "#{vertex.v}, "}; print "\n"}
end

  ##Additional fields:
  #
  ##List used for marking visited vertices
  attr_accessor :vis
  #
  ##Reference to the constructed graph of strongly consistent component
  attr_accessor :scc_res

  ##Shortcuts :
  def g()
    return @vertexes
  end

end

#Extension to Vertexes in strongly connected component graph
# it has additional field "c" it contains information
# about the component to which it belongs
class Component
  def initialize
    #At start we didn't has component
    # to which we belongs
    @c = -1
  end
  attr_accessor :c
end