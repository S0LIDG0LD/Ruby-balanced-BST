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

  def delete(value, node = root)
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

  def height(value, node = root, height = 0, found = false, heights = [])
    return heights << (found ? height : nil) if node.nil?

    if value == node.data
      found = true
    elsif found
      height += 1
    end
    height(value, node.left, height, found, heights) if value < node.data || found
    height(value, node.right, height, found, heights) if value > node.data || found
    heights.max
  end

  def depth(value, height = 1, queue = [], node = root)
    return height if value == node.data

    height += 1
    queue << node.left if value < node.data && !node.left.nil?
    queue << node.right if value > node.data && !node.right.nil?
    return nil if queue.empty?

    depth(value, height, queue, queue.shift)
  end

  def find(value, node = root)
    return node if node.nil? || node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  def level_order(node = root, queue = [], array = [])
    array << node.data unless node.data.nil?
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return array if queue.empty?

    level_order(queue.shift, queue, array)
  end

  def inorder(node = root, array = [])
    inorder(node.left, array) unless node.left.nil?
    array << node.data unless node.nil?
    inorder(node.right, array) unless node.right.nil?
    array
  end

  def preorder(node = root, array = [])
    array << node.data unless node.nil?
    preorder(node.left, array) unless node.left.nil?
    preorder(node.right, array) unless node.right.nil?
    array
  end

  def postorder(node = root, array = [])
    postorder(node.left, array) unless node.left.nil?
    postorder(node.right, array) unless node.right.nil?
    array << node.data unless node.nil?
    array
  end

  def rebalance
    @root = build_tree(inorder)
  end

  def balanced?(node = root)
    return true if node.nil?

    left_height = (node.left.nil? ? 0 : height(node.left.data, node.left))
    right_height = (node.right.nil? ? 0 : height(node.right.data, node.right))
    (left_height - right_height).abs < 2 && balanced?(node.left) && balanced?(node.right)
  end
  # def preorder(node = root, array = [])
  #   return nil if node.nil?

  #   array << node.data unless node.nil?
  #   preorder(node.left, array) unless node.left.nil?
  #   preorder(node.right, array) unless node.left.nil?
  #   array
  # end

  # def postorder(node = root, array = [])
  #   postorder(node.left, array) unless node.left.nil?
  #   postorder(node.right, array) unless node.left.nil?
  #   array << node.data unless node.nil?
  #   array
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
