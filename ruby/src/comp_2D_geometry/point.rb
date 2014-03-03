# This file contain class that combine to Point
# on the flat plane with x and y coordinates
#
# Author::    Mazeryt Freager  (mailto:skirki@o2.pl)
# Copyright:: GitHub
# License::   GitHub::Rubyrithms project

class Point

  def initialize(x = 0 , y = 0)
    @x = x
    @y = y
  end

  def == (item)
    result = false

    if(item.x == self.x and item.y == self.y)
      result = true
    end

    return result
  end

  ##Public access to x-coordinate.
  attr_accessor :x
  ##Public access to y-coordinate.
  attr_accessor :y

end