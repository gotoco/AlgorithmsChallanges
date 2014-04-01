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

  def initialize(number_of_vertex, object=nil)
    @vertexes = Array.new(number_of_vertex)
    @vertexes.each_with_index{|v, i| @vertexes[i] = Vertex.new(object, Array.new, i)}
  end

  #Simple method to write whole graph structure
  def write_graph
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
      @vertexes[v_source_number].o = edge_object
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

  #Breadth-first search (BFS) is a strategy for searching in a graph when
  # search is limited to essentially two operations:
  # (a) visit and inspect a node of a graph;
  # (b) gain access to visit the nodes that neighbor the currently visited node.
  # The BFS begins at a root node and inspects all the neighboring nodes.
  # Then for each of those neighbor nodes in turn,
  # it inspects their neighbor nodes which were unvisited, and so on.
  #
  # After the BFS algorithm, field int t vertex contains the distance from the source
  # (-1 if the vertex is unreachable from the source),
  # the field int s contains the number of father in the BFS tree
  # (which is the source for the vertex and the vertex search is unattainable -1)
  #
  # * *Args*    :
  #   - +source_vertex+ -> the number of source vertex in BFS algorithm 0 if no arg passed
  def bfs(source_vertex_number=0)
    ##Start
    s = source_vertex_number
    #For each vertex in the graph is set to the initial value of the variable
    #t and s to -1. Source search has time equal to 0
    @vertexes.each do |v|
       if v != nil
         v.t=-1; v.s=-1;
       end
    end

    @vertexes[s].t=0

    #BFS algorithm is implemented using a FIFO queue, which inserted
    #consecutive vertices are waiting to be processed
    qu = Array.new(@vertexes.size);
    #insert into queue source
    qu[b = e = 0] = s
    #while we have vertexes in queue
    while(b <= e)
      s=qu[b]; b +=1 ;

      #For each outgoing edge of the currently processed vertex,
      #if the vertex to which it leads has not yet been inserted into the
      #queue, insert it, and determine values of variables int t and int s
      @vertexes[s].each do |eg|
        if @vertexes[eg.v].t == -1
            e+=1
            qu[e] = eg.v
            @vertexes[eg.v].t = @vertexes[s].t+1
            @vertexes[eg.v].s = s
        end

      end

    end

  end

  #Simply method that show graph structure after bfs algorithm
  # it show each | Vertex : x | Time from source to v : t | Father in BFS tree : s |
  def write_bfs
    @vertexes.each do |v|
        print " Vertex : #{v.number} | t : #{v.t} | s : #{v.s} \n"
    end
  end

  #Depth-first search (DFS) algorithm for traversing or searching tree or graph data structures.
  # One starts at the root (selecting some arbitrary node as the root in the case of a graph)
  # and explores as far as possible along each branch before backtracking.
  #
  # After DFS algorithm fields on Vertex "d" and "f" are represented correspondingly
  # the inputs and outputs from the top, while s is the number of father-vertex : father
  # in the designated DFS forest.
  # This version of DFS is iterative implementation of this algorithm.
  #
  # * *Args*    :
  #   - +source_vertex+ -> the number of source vertex in DFS algorithm -1 if no arg passed
  def dfs(source_vertex_number=-1)
    ##Start!
    e=source_vertex_number
    #Create stack to handle processed vertexes
    st = Array.new(@vertexes.size){|e| e=0}
    #Time zero, iterator zero, b-start search point
    t = -1; i = 0; b = 0;
    e == -1 ? e = @vertexes.size - 1 : b = e

    #Set each vertexes as unvisited
    @vertexes.each_index{|i|  @vertexes[i].d = @vertexes[i].f = @vertexes[i].s = -1;}

    #FOR EACH vertexes in the range [b..e], if vertex was unvisited..
    # s : global source
    for s in b..e  ; if @vertexes[s].d == -1
        #Insert vertex on the stack and set it to the appropriate time of entry.
        #Vertex variable "f" is used as temporarily counter for unprocessed
        #Outgoing edges of the vertex

        t+=1 # time is going so increment time

        @vertexes[st[i]=s].d = t
        i+=1 #incremented iterator
        @vertexes[s].f = @vertexes[s].size
        #While stack is not empty..
           while(i>0)
             #ts : temporary source
             ts = st[i-1]
             #Parse the next Edge leading off from the current vertex or
             # remove it from the stack (when there is no edge anymore).
             if @vertexes[ts].f == 0

               t+=1 #time is going

               @vertexes[ts].f = t; i-=1; #we have to iterate one v less
             else
               #If vertex, to whose leading Edge, was not yet visited then..
               vn = @vertexes[ts].f -= 1    # vertexes number to visit +1 because start from 0
               ts = @vertexes[ts][vn].v     # change temporary source to next vertex
               if @vertexes[ts].d == -1
                  #Set the number of vertex-father in the DFS tree, and set the number of unprocessed
                  #outgoing edges of the vertex
                  @vertexes[ts].s = st[i-1]
                  @vertexes[ts].f = @vertexes[ts].size
                  #Put current vertex on stack and set it entry time

                  t+=1 #time is going

                  @vertexes[st[i] = ts].d = t;
                  i+=1;  #we have new vertex on stack to process,
               end
             end
           end

    end; end;

  end

  #Simply method that show graph structure after dfs algorithm
  # it show each | Vertex : x | Enter time : d | Exit time : f | Father in DFS tree : s |
  def write_dfs
    @vertexes.each do |v|
      print " Vertex : #{v.number} | d : #{v.d} | f : #{v.f} | s : #{v.s} \n"
    end
  end

  # Simply method to clean up after searching algorithms
  # because bfs and dfs handle data in graph structure
  def clean_after_searching

  end

  ##Read only accessor to vertexes.
  attr_reader :vertexes

  def g()
    return vertexes
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

    #Searching algorithms values
    @t = -1
    @s = -1
    @d = -1
    @f = -1
  end

  ##Decorator access method
  def method_missing(method, *args, &block)
    @o.send(method, *args, &block)
  end

  ##Public access to decorated object
  attr_accessor :o

  ##Public access to number of the vertex
  attr_accessor :number

  ##Time/Dimension from BFS source vertex
  # (-1 if this vertex is unreachable from source)
  attr_accessor :t

  ##Father in the BFS algorithm tree
  attr_accessor :s

  ##Enter time of DFS algorithm
  attr_accessor :d

  ##Exit time of DFS algorithm
  attr_accessor :f

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
