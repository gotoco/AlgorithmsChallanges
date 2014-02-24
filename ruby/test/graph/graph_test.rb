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
    # Vertex : 1 | t : 1 | s : 2
    # Vertex : 2 | t : 0 | s : -1    <- source in BFS algorithm
    # Vertex : 3 | t : 2 | s : 1
    # Vertex : 4 | t : 1 | s : 2
    # Vertex : 5 | t : 1 | s : 2
    #########################################################################################
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

end

