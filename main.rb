# frozen_string_literal: true

require_relative 'lib/tree'
require_relative 'lib/node'

# array = Array.new(15) { rand(1..100) }
# array = Array.new(15) { rand(1..15) }
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
# array = [1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 50, 70]
# array = [12]
tree = Tree.new(array)
# abc = Tree.new
# puts tree.root.data
# puts tree.root.left.data
# puts tree.root.right.data
# puts tree
# tree.nodes.each { |value| print "#{value.data} ," }
# puts
# puts abc
tree.insert(50)
tree.insert(70)
# puts tree
# tree.delete(50)
# puts tree
tree.delete(6)
# puts tree
# tree.nodes.each { |value| print "#{value.data} ," }
# puts
# puts tree.nodes.one?(7)
tree.delete(8)
puts tree
# puts tree.find(9).data
puts 'height 9, 5, 10, 15, 50: '
puts tree.height(9)
puts tree.height(4)
puts tree.height(10)
puts tree.height(15)
puts tree.height(51)
# puts 'level order:'
# puts tree.level_order
# puts 'inorder'
# puts tree.inorder
# puts 'preorder'
# puts tree.preorder
# puts 'postorder'
# puts tree.postorder
tree.rebalance
puts tree
