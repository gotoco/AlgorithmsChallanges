class SccGraphTest

  def initialize(v, c)
    @v = v
    @c = c
  end

  attr_accessor :v
  attr_accessor :c

end

array = [SccGraphTest.new(0,0),
 SccGraphTest.new(1,0),
SccGraphTest.new(2,2),
SccGraphTest.new(3,2),
SccGraphTest.new(4,2),
SccGraphTest.new(5,1),
SccGraphTest.new(6,3),
SccGraphTest.new(7,4)]

#print array

=begin
grouped_array = array.group_by{|e| e.c}.values
   print  "\n grupuje! \n"
print grouped_array
=end

array.group_by{|e| e.c}.values.each{|component| print "#{component.first.c} : "; component.each{|vertex| print "#{vertex.v}, "}; print "\n"}