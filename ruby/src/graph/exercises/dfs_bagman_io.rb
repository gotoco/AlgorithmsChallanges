########################################################################################################################
#----------------------------------------
# Exercise:  "Traveling salesman Byteazar"
# Origin:    "IX Informatics olympiad"
#----------------------------------------
########################################################################################################################
# The salesman Byteasar working hard traveling Byteotia. In ancient times, traveling salesmen
# they could choose the city that wanted to visit and the order in which they did,
# But those days are gone forever. With the establishment of the Central Authority for Controll
# Travelling Salesmens, each salesman receives from the Office of the list of cities that can visit
# generously and the order in which they should do so. As is usually the case with the central authorities,
# the imposed order of visiting cities do not have much in common with an optimal order.
# Before heading out on tour Byteasar would like to at least find out how much time it will take
# him to visit all the cities - to calculate this is your job.
# Cities in Byteotia are numbered from 1 to n number 1 is the capital Byteotia, it poured
# dream begins a journey Byteasar. Cities are connected by two-way roads.
# Journey between the two cities directly connected by a road always takes 1 unit of time.
# From the capital, you can reach all the cities Byteotia. However, the road network was
# designed very sparingly, so the roads never form cycles.
########################################################################################################################
# TO Be Done:
# Write a program that:
# - reads the description of the road network Byteotia and a list of cities that must visit Byteasar
# - calculate the total time Byteasar,  
# - writes the result to stdout
#
# INPUT:
#
#  The first line of input there is one integer n equal to the number of cities in
# Byteotia (1 <= n <= 30 000). In the following n - 1 lines is described road network - in any
# of these lines are two integers a and b (1 <= a, b ​​<= n, a = b), meaning
# that city a and b are connected by road. In line with the number n + 1 there is one
# m is the total number of cities that you should visit Byteasar, (1 <= m <= 50 000). In
# the next m lines recorded numbers of the following cities on the itinerary Byteasar - after
# one number per line.
#
# OUTPUT:
#
# The first and only line of the output should be one integer equal to the total time of Byteasar.
#
########################################################################################################################

#Libraries:
require "../graph"

class TravelingTree < Graph
  #Extend vertices by an additional array "l" of ancestors
  def initialize (vertex_object= Class.new do
    def initialize
      @l = Array.new
    end
    attr_accessor :l
  end)
     super vertex_object
  end

  #Return true if n is ancestor of vertex m in this tree
  def is_ancestor(n, m)
    return g[n].d <= g[m].d and g[n].f >= g[m].f
  end

  #Return the distance of vertex "b" to path leading from vertex "e" to tree root
  def length_from_ancestor_to_root(vertex_b, vertex_e)
    res= 0 ; p= g[b].l.size-1

    #While vertex_b is not a ancestor of vertex_e...
    while(!is_ancestor(vertex_b, vertex_e))
      #Using calculated values of ancestors in "l" array move through top of the tree
      # making for each time a step with size that is a power of 2
      p= [p, g[b].l.size-1].min
      while(p>0 and is_ancestor(g[b].l[p], e)) do p-=1 ; end
      #Increse calculated distance of the size of step and make this step
      res += (1<<p)

    end

    return result
  end

end

