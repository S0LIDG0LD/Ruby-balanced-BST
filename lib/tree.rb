# frozen_string_literal: true

# a Ruby implementation of a balanced BST
class Tree
  attr_reader :root

  def initialize
    @root = nil
    @nodes = []
  end

  def build_tree(array)
    create_bst(array.uniq.sort, 0, array.uniq.sort.size - 1)
    @root = @nodes[0]
  end

  def create_bst(array, start, size)
    return nil if start > size

    mid = (start + size) / 2
    new_node = Node.new(array[mid])
    puts "node.data: #{new_node.data}"
    @nodes << new_node
    # left = array[0..(mid - 1)]
    # left&.each { |x| print x }
    new_node.left = create_bst(array, start, mid - 1)
    # right = array[(mid + 1)..(array.size - 1)]
    # right&.each { |x| print x }
    new_node.right = create_bst(array, mid + 1, size)
    new_node
  end

  def to_s(node = @root, prefix = '', is_left = true)
    # puts "node.data: #{node.data}"
    # puts "nodes: #{@nodes}"
    # puts 'pretty_print'
    # puts "pp root.data: #{node}"
    # puts "pp prefix: #{prefix}"
    # puts "pp is_left: #{is_left}"
    # https :/ / docs.rubocop.org / rubocop / cops_style.html # styleoptionalbooleanparameter
    # puts "node right: #{node.right == true }"    
    to_s(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    to_s(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
