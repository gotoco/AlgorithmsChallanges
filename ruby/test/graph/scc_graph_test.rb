

require '../../../ruby/src/graph/graph_extensions/scc_graph'
require 'set'
require 'minitest/unit'
require 'minitest/autorun'

class SccGraphTest < MiniTest::Unit::TestCase

  def test_simple_scc
    print "build simple graph with 8 vertex and 10 directed edges \n"

    graph = SccGraph.new(8)

    graph.add_edge_d(0, 1)
    graph.add_edge_d(1, 0)
    graph.add_edge_d(0, 7)
    graph.add_edge_d(1, 6)
    graph.add_edge_d(6, 7)
    graph.add_edge_d(1, 2)
    graph.add_edge_d(1, 3)
    graph.add_edge_d(3, 2)
    graph.add_edge_d(2, 4)
    graph.add_edge_d(4, 3)
    graph.add_edge_d(5, 3)


    graph.scc_graph

    graph.write_scc

    #########################################################################################
    # We expect graph with given structure with 5 separate components
    # 0 :   0, 1
    # 1 :   5
    # 2 :   2, 3, 4
    # 3 :   6
    # 4 :   7
    #########################################################################################
=begin
    assert(Set.new(graph.get_vertex(0).map { |v| v.v} )  == Set.new([1]) )
    assert(Set.new(graph.get_vertex(1).map { |v| v.v} )  == Set.new([2]) )
    assert(Set.new(graph.get_vertex(2).map { |v| v.v} )  == Set.new([4]) )
    assert(Set.new(graph.get_vertex(3).map { |v| v.v} )  == Set.new([4, 2]) )
    assert(Set.new(graph.get_vertex(4).map { |v| v.v} )  == Set.new([1, 0, 3]) )
=end

  end

end