# frozen_string_literal: true

# a Ruby implementation of a balanced BST
class Tree
  attr_reader :root, :nodes, :data

  def initialize(array)
    @data = array.uniq.sort
    @root = build_tree(data)
  end

  def leaf_node?(node)
    node.right.nil? && node.left.nil?
  end

  def node_both_children?(node)
    !node.right.nil? && !node.left.nil?
  end

  def left_child_only?(node)
    node.right.nil?
  end

  def right_child_only?(node)
    node.left.nil?
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.size - 1) / 2
    new_node = Node.new(array[mid])
    new_node.left = build_tree(array[0...mid])
    new_node.right = build_tree(array[(mid + 1)..])
    new_node
  end

  def insert(value, node = root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  # def swap_node(deleted_node, new_node)
  #   deleted_node.data = new_node.data
  #   deleted_node.right = new_node.right
  #   deleted_node.left = new_node.left
  # end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if right_child_only?(node)
      return node.left if left_child_only?(node)

      leftmost_node = leftmost_leaf(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
    node
  end

  #   elsif value == node.data
  #     if leaf_node?(node)
  #       nil
  #       puts 'value == node.data'
  #     elsif right_child_only?(node)
  #       swap_node(node, node.right)
  #     elsif left_child_only?(node)
  #       swap_node(node, node.right)
  #     elsif node_both_children?(node)
  #       # left_tree = node.left
  #       # left_tree = left_tree.right until left_tree.right.nil?
  #       # node.data = letf_tree.value
  #       # delete
  #     end
  #     @nodes.delete(value)
  #     nil
  #   elsif leaf_node?(node)
  #     nil
  #   else
  #     node = delete(value, node.left) unless right_child_only?(node)
  #     node = delete(value, node.right) unless left_child_only?(node)
  #   end
  # end

  def to_s(node = @root, prefix = '', is_left = true)
    to_s(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    to_s(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def leftmost_leaf(node)
    node = node.left until node.left.nil?

    node
  end
end
