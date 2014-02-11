def Graph
  def initialize(*vertexes)
    @vertexes = vertexes
  end
end

def Vertex
  def initialize(object, *edges)
    @o = object
    @e = edges
  end
end

def Edges
  def initialize(object, vertex)
    @o = object
    @v = vertex
  end
end