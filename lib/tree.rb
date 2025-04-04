require_relative 'node.rb'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    # remove duplicated and sort
    array = array.uniq.sort

    # Recursively divide and construct tree
    build_subtree(array)
  end

  def build_subtree
    return nil if array.empty?

    # find middle element
    mid = array.length/2
    root = Node.new(array[mid])

    # left and right subtrees
    root.left_child = build_subtree(array[0...mid])
    root.right_child = build_subtree(array[mid + 1..-1])
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end