require '../../../ruby/src/graph/graph'
require 'set'
require 'minitest/unit'
require 'minitest/autorun'

class GraphTest < MiniTest::Unit::TestCase
  
  def test_simple_d_graph
    print "build simple graph with 5 vertex and 8 edges \n"

    graph = Graph.new(5)

    graph.add_edge_d(0, 1)
    graph.add_edge_d(3, 4)
    graph.add_edge_d(4, 1)
    graph.add_edge_d(4, 0)
    graph.add_edge_d(1, 2)
    graph.add_edge_d(2, 4)
    graph.add_edge_d(3, 2)
    graph.add_edge_d(4, 3)


    #########################################################################################
    # We expect graph with given structure co each vertex should have expected list of edges
    # graph.write will show us:
    # 0 :   1
    # 1 :   2
    # 2 :   4
    # 3 :   4  2
    # 4 :   1  0  3
    #########################################################################################
    assert(Set.new(graph.get_vertex(0).map { |v| v.v} )  == Set.new([1]) )
    assert(Set.new(graph.get_vertex(1).map { |v| v.v} )  == Set.new([2]) )
    assert(Set.new(graph.get_vertex(2).map { |v| v.v} )  == Set.new([4]) )
    assert(Set.new(graph.get_vertex(3).map { |v| v.v} )  == Set.new([4, 2]) )
    assert(Set.new(graph.get_vertex(4).map { |v| v.v} )  == Set.new([1, 0, 3]) )

  end

  def test_simple_u_graph
    print "build simple graph with 5 vertex and 8 edges \n"

    graph = Graph.new(5)

    graph.add_edge_u(0, 1)
    graph.add_edge_u(3, 4)
    graph.add_edge_u(4, 1)
    graph.add_edge_u(4, 0)
    graph.add_edge_u(1, 2)
    graph.add_edge_u(2, 4)
    graph.add_edge_u(3, 2)
    graph.add_edge_u(4, 3)

    #########################################################################################
    # We expect graph with given structure co each vertex should have expected list of edges
    # graph.write will show us:
    # 0 :   1  4
    # 1 :   0  4  2
    # 2 :   1  4  3
    # 3 :   4  2  4
    # 4 :   3  1  0  2  3
    #########################################################################################
    assert(Set.new(graph.get_vertex(0).map { |v| v.v} )  == Set.new([1, 4]) )
    assert(Set.new(graph.get_vertex(1).map { |v| v.v} )  == Set.new([0, 2, 4]) )
    assert(Set.new(graph.get_vertex(2).map { |v| v.v} )  == Set.new([1, 3, 4]) )
    assert(Set.new(graph.get_vertex(3).map { |v| v.v} )  == Set.new([4, 2]) )
    assert(Set.new(graph.get_vertex(4).map { |v| v.v} )  == Set.new([1, 0, 3, 2]) )

  end

  def test_simple_bfs_for_graph
    print "build simple graph with 6 vertex and 5 edges \n"

    graph = Graph.new(6)

    graph.add_edge_u(3, 1)
    graph.add_edge_u(2, 1)
    graph.add_edge_u(2, 4)
    graph.add_edge_u(2, 5)
    graph.add_edge_u(4, 5)

    graph.bfs(2)
    #########################################################################################
    # For Given graph structure and source vertex s=2 we expect BFS tree as follow
    # graph.write_bfs will show us:
    # Vertex : 0 | t : -1 | s : -1   <- undirected vertex
    # Vertex : 1 | t : 1 | s : 2
    # Vertex : 2 | t : 0 | s : -1    <- source in BFS algorithm
    # Vertex : 3 | t : 2 | s : 1
    # Vertex : 4 | t : 1 | s : 2
    # Vertex : 5 | t : 1 | s : 2
    #########################################################################################

    assert_equal(graph.vertexes[0].t, -1)
    assert_equal(graph.vertexes[0].s, -1)

    assert_equal(graph.vertexes[1].t, 1)
    assert_equal(graph.vertexes[1].s, 2)

    assert_equal(graph.vertexes[2].t, 0)
    assert_equal(graph.vertexes[2].s, -1)

    assert_equal(graph.vertexes[3].t, 2)
    assert_equal(graph.vertexes[3].s, 1)

    assert_equal(graph.vertexes[4].t, 1)
    assert_equal(graph.vertexes[4].s, 2)

    assert_equal(graph.vertexes[5].t, 1)
    assert_equal(graph.vertexes[5].s, 2)

  end

  def test_simple_dsf_for_graph
    print "build simple graph with 7 vertex and 6 edges \n"

    #GIVEN
    graph = Graph.new(6)

    graph.add_edge_u(0, 1)
    graph.add_edge_u(2, 3)
    graph.add_edge_u(2, 4)
    graph.add_edge_u(3, 5)
    graph.add_edge_u(3, 6)
    graph.add_edge_u(6, 5)

    #WHEN
    graph.dfs(3)

    #########################################################################################
    # For Given graph structure and source vertex s=3
    # we expect BFS tree as follow
    # NOTICE that result is dependent on the order of insertion edge of the graph
    # graph.write_dfs will show us:
    # Vertex : 0 | d : -1 | f : -1 | s : -1   <- unreachable from source 3 vertex
    # Vertex : 1 | d : -1 | f : -1 | s : -1   <- unreachable from source 3 vertex
    # Vertex : 2 | d : 5  | f : 8  | s : 3
    # Vertex : 3 | d : 0  | f : 9  | s : -1    <- source in BFS algorithm
    # Vertex : 4 | d : 6  | f : 7  | s : 2
    # Vertex : 5 | d : 2  | f : 3  | s : 6
    # Vertex : 6 | d : 1  | f : 4  | s : 3
    #########################################################################################

    #THEN
    assert_equal(graph.vertexes[0].d, -1)
    assert_equal(graph.vertexes[0].f, -1)
    assert_equal(graph.vertexes[0].s, -1)

    assert_equal(graph.vertexes[1].d, -1)
    assert_equal(graph.vertexes[1].f, -1)
    assert_equal(graph.vertexes[1].s, -1)

    assert_equal(graph.vertexes[2].s, 3)

    assert_equal(graph.vertexes[3].s, -1)
    assert_equal(graph.vertexes[3].f, 9)   #because we will process 9 vertexes
    assert_equal(graph.vertexes[3].d, 0)   #because it is source vertex

    assert_equal(graph.vertexes[4].s, 2)
    assert(graph.vertexes[4].d > graph.vertexes[2].d)

    assert(graph.vertexes[5].s == 3 || graph.vertexes[5].s == 6)
    assert(graph.vertexes[5].d > graph.vertexes[3].d)

    assert(graph.vertexes[6].s == 3 || graph.vertexes[6].s == 5)
    assert(graph.vertexes[6].d > graph.vertexes[3].d)

  end


  def test_full_dsf_for_graph
    print "build simple graph with 7 vertex and 6 edges \n"

    #GIVEN
    graph = Graph.new(6)

    graph.add_edge_u(0, 1)
    graph.add_edge_u(2, 3)
    graph.add_edge_u(2, 4)
    graph.add_edge_u(3, 5)
    graph.add_edge_u(3, 6)
    graph.add_edge_u(6, 5)

    #WHEN
    graph.dfs()
    #########################################################################################
    # For Given graph structure and source vertex s=3
    # we expect BFS tree as follow
    # NOTICE that result is dependent on the order of insertion edge of the graph
    # graph.write_dfs will show us:
    # Vertex : 0 | d : 0 | f : 3  | s : -1
    # Vertex : 1 | d : 1 | f : 2  | s : 0
    # Vertex : 2 | d : 4 | f : 13 | s : -1
    # Vertex : 3 | d : 7 | f : 12 | s : 2
    # Vertex : 4 | d : 5 | f : 6  | s : 2
    # Vertex : 5 | d : 9 | f : 10 | s : 6
    # Vertex : 6 | d : 8 | f : 11 | s : 3
    #########################################################################################

    assert(graph.vertexes[0].s == -1 || graph.vertexes[1].s == -1 )

    set_entry = graph.vertexes[2..6].map {|v| v.d}
    set_exit = graph.vertexes[2..6].map {|v| v.f}
    set_flow = set_entry.concat(set_exit)

    assert( graph.vertexes[2..6].map {|v| v.d}.length == 5  )
    assert( graph.vertexes[2..6].map {|v| v.f}.length == 5  )

    assert( set_flow.length == 10 )

  end

end

