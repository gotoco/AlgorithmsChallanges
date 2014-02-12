class Graph
  def initialize(*vertexes)
    @vertexes = vertexes
  end

  def write
    @vertexes.each  do |vertex|
      print vertex.o
      print vertex.number
      end
  end
end

class Vertex < Array

  def initialize(object, edges_list, vertex_number)
    super edges_list
    @o = object
    @number = vertex_number
  end

  attr_accessor :o

end

class Edges
  def initialize(object, vertex)
    @o = object
    @v = vertex
  end
end
