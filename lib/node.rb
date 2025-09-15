# frozen_string_literal: true

# a Ruby implementation of a node of a balanced BST
class Node
  include Comparable

  attr_accessor :data, :left, :right

  # def <=>(other)
  #   data <=> other.data
  # end

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end
