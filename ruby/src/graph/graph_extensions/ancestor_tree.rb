require "../graph"

#Extension to Vertexes in AncestorsTree
#They store information about they Ancestors
class Ancestors
  def initialize
    @l = Array.new
  end
  attr_accessor :l
end

class AncestorTree < Graph
  #Extend vertices by an additional array "l" of ancestors
  def initialize (number_of_nodes)
    super number_of_nodes, ListOfAncestors
  end

  #Return true if n is ancestor of vertex m in this tree
  def is_ancestor(n, m)
    return ( g[n].d <= g[m].d and g[n].f >= g[m].f )
  end

  #Return the distance of vertex "b" to path leading from vertex "e" to tree root
  def lca(vertex_b, vertex_e)
    b=vertex_b; e=vertex_e
    res= 0 ; p= g[b].l.size-1

    #While vertex_b is not a ancestor of vertex_e...
    while(!is_ancestor(b, e))
      #Using calculated values of ancestors in "l" array move through top of the tree
      # making for each time a step with size that is a power of 2
      power= g[b].l.size-1
      p= [p, power].min
      while(p>0 and is_ancestor(g[b].l[p], e)) do p-=1 ; end
      #Increse calculated distance of the size of step and make this step
      res += (1<<p)
      b = g[b].l[p]
    end

    return res
  end

  #This function calculate each value of arrays "l" for each tree nodes.For given vertex v
  # subsequent elements of array "l" represents vertexes numbers with range 1, 2, 4 ..
  # from vertex v to the root of tree (vertex nr. 0)
  def gen_lca(vertex)
    if vertex != 0 and g[vertex].l.size == 0
      c = g[vertex].s
      #Calculate list "l" for father of "v"
      gen_lca(c)
      #Put into list "l" of vertex "v" his father as a first element
      g[vertex].l.push(c)
      #Using LCA array of ancestors for calculate a result for vertex "v"
      while  g[c].l.size >=  g[vertex].l.size
        c = g[c].l[g[vertex].l.size-1]
        g[vertex].l.push(c)
      end
    end
  end

end