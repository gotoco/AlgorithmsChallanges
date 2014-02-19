# This file contain class that combine to Graph
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
=begin
  def initialize(*vertexes)
    @vertexes = vertexes
  end
=end

  def initialize(number_of_vertex)
    @vertexes = Array.new(number_of_vertex)
  end

  #Simple method to write whole graph structure
  def write
    @vertexes.each_with_index  do |vertex, index|
      print "\n #{index} :  "
      # For each edges that come out from vertex with number x
      # print vertex number to which edge leads
      vertex.each{ |eg| print " #{eg.v} " }
    end
  end

  def get_vertex(number_of_vertex)
      return @vertexes[number_of_vertex]
  end

  # This method add to graph new direct edge between two vertexes
  # additionally handle information about edge object.
  #
  # * *Args*    :
  #   - +v_source_number+ -> the number of source vertex from which comes out the edge
  #   - +v_target_number+ -> the number of target vertex to which enters edge
  #   - +edge_object+ -> the edge object, if any object is pass, default edge will be created
  def add_edge_d(v_source_number, v_target_number, edge_object=Edge.new(nil, v_target_number))

    if @vertexes[v_source_number] == nil
      @vertexes[v_source_number] = Vertex.new(edge_object, Array.new, v_source_number)
    end

    @vertexes[v_source_number].push edge_object
  end

  # This method add to graph new undirected edge between two vertexes
  # additionally handle information about edge object.
  # In undirected graphs class Edges have to handle integer:rev field.
  # Given a directed edge (b,e), this field stores the position of the edge (e, b)
  # the top of the list of incidence E.
  # Thus, for any edges in the graph at the time constant can be found on the edge of the opposite sense.
  #
  # * *Args*    :
  #   - +v_source_number+ -> the number of source vertex from which comes out the edge
  #   - +v_target_number+ -> the number of target vertex to which enters edge
  #   - +edge_object+ -> the base edge object to be decorated by Edge class,
  #                       if any object is pass, default edge will be created
  def add_edge_u(v_source_number, v_target_number, edge_object=Edge.new(nil, v_target_number))
    eg = Edge.new(edge_object, v_target_number)
    loop = 0
    if v_source_number ==  v_target_number
      loop = loop+1
    end

    if @vertexes[v_source_number] == nil
      @vertexes[v_source_number] = Vertex.new(edge_object, Array.new, v_source_number)
    end
    if @vertexes[v_target_number] == nil
      @vertexes[v_target_number] = Vertex.new(edge_object, Array.new, v_target_number)
    end

    eg.rev= @vertexes[v_target_number].size + loop
    @vertexes[v_source_number].push(eg)
    eg2 = Edge.new(edge_object, v_source_number)
    eg2.rev = @vertexes[v_source_number].size - 1;
    @vertexes[v_target_number].push(eg2)
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
# features and properties.
#########################################################################
class Vertex < Array

  ## Simple constructor of the Vertex object
  # * *Args*    :
  #   - +object+ -> the object that will be represented by this vertex
  #   - +edges_list+ -> list of outgoing edges from this vertex
  #   - +vertex_number+ -> conventional number of this vertex in graph.
  #
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
# which the edge leads.
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

  ##Public access to number of edges in opposite sense.
  attr_accessor :rev
  ##Public access to number of the vertex
  attr_accessor :v

end
