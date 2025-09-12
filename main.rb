# frozen_string_literal: true

require_relative 'lib/tree'
require_relative 'lib/node'

array = Array.new(15) { rand(1..100) }
tree = Tree.new
tree.build_tree(array)
# abc = Tree.new
# puts tree.root.data
# puts tree.root.left.data
# puts tree.root.right.data
puts tree
# puts abc
tree.insert(50)
puts tree