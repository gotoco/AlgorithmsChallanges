########################################################################################################################
#----------------------------------------
# Exercise:  "Ants and Ladybug"
# Origin:    "VIII Informatics olympiad"
#----------------------------------------
########################################################################################################################
# Problem:
#
# As you know, the ants are able to breed aphids. Aphids secrete a sweet honey dew ,
# which ants drinks . Ants defend aphids against their greatest enemies - ladybirds .
# On the tree next to the nest is just such a breeding aphids. Aphids feed on
# leaves and branches of a tree. In some of these places are also
# ants patrolling the tree . For definiteness , ants are numbered from one upwards.
# Breeding threatened ladybug who always sits in a tree where there are aphids, ie
# leaves or branches . The moment you sit somewhere on a tree ladybug , ants
# patrolling tree moving toward her to chase her away. Directed at the following
# principles:
#      
# - from anywhere in the tree ( leaf or branch ) you can walk to any other
#   space (without turning ) in only one way , each ant chooses just such a
#   the way to the landing site ladybugs ,
#
# - if the landing site is located ant ladybug , ladybug fly away immediately ,
#
# - if on the road, from the current position of ants to land ladybugs ,
#   will be another ant , it is located further away from the ladybugs journey ends and is in
#   place your current location,
#
# - if two or more ants trying to enter the same branching tree , it does
#   is just one ant - the one with the lowest number , and the rest of the ants remains
#   place ( leaves or branches ),
#   ant that reaches the landing site ladybugs , chases her and remains in this place.
#   Ladybug is stubborn and dunk on a tree. Then again ants move to chase the intruder.
#
#  For simplicity , we assume that the transition connecting twigs with leaves branching or combining two branches ,
#  it takes all the ants unit of time .
#
# TO Be Done:
# Write a program that:
# - reads the description of the tree, petals start position of ants and the place where the succession
#   ladybug lands,
# - for each ant finds its final position and determines the number of ACA says how many times
#     chased the ladybug.
#
# INPUT:
#
# The first line of input contains one integer n , equals the total number of leaves and
#     branches in the tree , 1 < = n < = 5 000 We assume that the leaves and branches are numbered
# from 1 to n in the following n - 1 lines are described twigs - in each of the rows are
# two integers a and b indicate that the branch connects the space and b Twigs
# allow you to go from any place on the tree, to any other place . In the n + 1-st
# line there is one integer k , 1 < = k < = 1, 000, k <= n , equal to the number of ants
# patrolling the tree . Each of the next k lines contains a single integer
# in the range from 1 to n the number stored in row n + 1 + i is the initial position
# No ant i at any location ( or bifurcation leaf ) can be at most
# an ant . In the row n + k + 2 there is one integer l , 1 < = l < = 500 ,
# that is telling how many times ladybug sits on a tree. In each of the following rows is stored l
# one integer from 1 to n These figures describe more places sits
# ladybug .
#
# OUTPUT
#
# Your program should write k lines. The i-th line should be written two
# integers separated by a single space - the final position of the i-th ants (number
# branch or leaf), and - the number of times she chased a ladybug.
########################################################################################################################

#Libraries:
require "../graph"

$INF =  1000000001

# This function mark each nodes in BFS subtree of node "v" as blocked (ants can't enter them)
def mark_subtree_as_blocked (g, v, t)
  g.g[v].t = t
  g.g[v].each {|it| if g.g[v].s != it.v and g.g[it.v].t == $INF
                    mark_subtree_as_blocked(g, it.v, t)
                  end  }

end

#Global variables:
n = 0 # Number of Nodes in graph
k = 0 # Number of Ants
l = 0 # Number of Ladybug landings
kpos = Array.new(1000) # This array contains Ants positions
knr  = Array.new(1000) # This array contains data about how many times Ant-"i" defends LadyBug
lst  = Array.new(1000) # This array is a queue of ants that have possibility to move

# Lets Start!
# Input data section
puts "Enter number of N nodes : "
n = gets.to_i
tree = Graph.new(n)

(n-1).times do
  puts "insert next connection in tree"
  a = gets.to_i
  b = gets.to_i
  tree.add_edge_u(a-1, b-1)
end

puts "Enter number of K ants : "
k = gets.to_i

puts "Enter positions of ants"

for i in 0..k-1
  puts "insert #{i} position : "
  kpos[i] = gets.to_i - 1
  knr[i] = 0
end

puts "Enter number of l Landing of LadyBug"
l = gets.to_i

# For each time when ladybug is landing
(l).times do
  len = k;  nlen = 0;  t = 2
  b = gets.to_i-1 # Node on which Ladybug is landing

  # Calculate BFS tree rooted in Ladybug landing node : b
  tree.bfs b

  # Mark nodes to which any ant can enter because they are subtree
  tree.g.each_with_index {|vertex, index| tree.g[index].t = $INF}
  for y in 0..k-1 do
    lst[y] = y
    mark_subtree_as_blocked(tree, kpos[lst[y]], 0)
  end

  while len>0
      # Try to move each Ant which can make move
      for y in 0..len-1
        # If current Ant is in the same node as LadyBug - cast she out
        if kpos[lst[y]] == b then
          knr[lst[y]] += 1
          len = 0
        # Else if Ant can't make move then remove it from list
        else
          index = kpos[lst[y]]
          e= tree.g[index].s
            if tree.g[e].t < t then
              lst[y] = -1
              # Move the Ant and block each nodes from its subtree
            else
              mark_subtree_as_blocked(tree, kpos[lst[y]] = e, t)
               tree.g[e].t = 0
            end
        end
      end
    # Update Ants list
    nlen = 0
    for x in 0..len-1 do if lst[x] != -1 then lst[nlen] = lst[x]; nlen+=1 end; end;
    len = nlen
    t+=1
  end
end

#End of algorithm : print result
for i in 0..k-1
  p  "Ant nr: #{i} ,pos : #{kpos[i]+1} ,chased : #{knr[i]} "
end