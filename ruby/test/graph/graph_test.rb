require '../../../ruby/src/graph/graph'
require "test/unit"

class GraphTest < Test::Unit::Test
  
  def test_simple

    v = Vertex.new(Test.new, [1,2,3,4,5,6,7,8,9], 3)


    v.each { |number| print number}
    v.o.dummy_method
  end

end

class Test
  def dummy_method
    print "dummy method"
  end
end
