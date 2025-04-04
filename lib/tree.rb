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

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left_child = insert(value, node.left_child)
    elsif value > node.data
      node.right_child = insert(value, node.right_child)
    end

    node
  end

  def delete(value, node = @root)
    return node if node.nil?
  
    if value < node.data
      node.left_child = delete(value, node.left_child)
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    else
      # Node found: handle cases
      if node.left_child.nil? && node.right_child.nil? # No children
        return nil
      elsif node.left_child.nil? # One child (right)
        return node.right_child
      elsif node.right_child.nil? # One child (left)
        return node.left_child
      else # Two children
        successor = find_min(node.right_child)
        node.data = successor.data
        node.right_child = delete(successor.data, node.right_child)
      end
    end
  
    node
  end
  
  def find_min(node)
    node = node.left_child until node.left_child.nil?
    node
  end

  def find(value, node = @root)
    return nil if node.nil?

    if value == node.data
      node
    elsif value < node.data
      find(value, node.left_child)
    else value > node.data
      find(value, node.right_child)
    end
  end
  
end