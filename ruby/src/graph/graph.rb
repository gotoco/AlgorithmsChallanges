# These file contain class that combine to Graph
# data structure, using these classes You can create
# fully functional Graph Object
#
# Author::    Mazeryt Freager  (mailto:skirki@o2.pl)
# Copyright:: GitHub
# License::   GitHub::Rubyrithms project



#########################################################################
# Graph is a class that contains set of Vertex-es, edges of graph are
# handled in individuals vertexes between which exist connections.
#########################################################################
class Graph
  def initialize(*vertexes)
    @vertexes = vertexes
  end

  ##Simple method to write whole graph structure
  def write
    @vertexes.each do |vertex|
      print vertex.o
      print vertex.number
    end
  end
end

#########################################################################
# Vertex expect to be a part of graph is also Decorator
# for given object in constructor also it extends Array object
# because it handle connection to other vertex-es in graph.
#
# Another feature of this class is that it extends Array class
# it may seem at first glance quite strange, but it is useful
# because allows you to easily iterate through all edges going
# out of vertex v: FOREACH (it, g [v])
#
# - For example vertex can be a City or geometrical lump with additional
#features and properties.
#########################################################################
class Vertex < Array

  def initialize(object, edges_list, vertex_number)
    super edges_list
    @o = object
    @number = vertex_number
  end

  ##Decorator access method
  def method_missing(method, *args, &block)
    @o.send(method, *args, &block)
  end

  ##Public access to decorated object
  attr_accessor :o
  ##Public access to number of the vertex
  attr_accessor :number

end

#########################################################################
# Edge is Decorator object to class given in constructor, decorated
# object contain whole information about edge of the graph.
# It contains also vertex field specifying the number of the vertex,
# which leads to the edge.
#########################################################################
class Edge
  def initialize(object, vertex)
    @o = object
    @v = vertex
  end

  ##Decorator access method
  def method_missing(method, *args, &block)
    @o.send(method, *args, &block)
  end

end
