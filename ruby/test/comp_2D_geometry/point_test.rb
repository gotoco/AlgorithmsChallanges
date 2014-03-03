require '../../../ruby/src/comp_2D_geometry/point'
require 'set'
require 'minitest/unit'
require 'minitest/autorun'

class PointTest  < MiniTest::Unit::TestCase

  def test_point_equal

   point_a = Point.new(1.11 , -1.11)
   point_b = Point.new()
   point_c = Point.new(1.11 , -1.11)

    assert( ! (point_a==point_b) )
    assert(point_a==point_c)

  end

end