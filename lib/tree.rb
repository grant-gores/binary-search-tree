require_relative './node.rb'

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

  def level_order(node = @root, &block)
    return [] if node.nil?
  
    queue = [node]
    values = []
  
    while !queue.empty?
      current = queue.shift
  
      if block_given?
        yield(current)
      else
        values << current.data
      end
  
      # Add children to the queue
      queue << current.left_child if current.left_child
      queue << current.right_child if current.right_child
    end
  
    values
  end

  def inorder(node = @root, values = [], &block)
    return values if node.nil?

    inorder(node.left_child, values, &block)
    if block_given?
      yield(node)
    else
      values << node.data
    end
    inorder(node.right_child, values, &block)

    values
  end

  def preorder(node = @root, values = [], &block)
    return values if node.nil?
  
    if block_given?
      yield(node)
    else
      values << node.data
    end
    preorder(node.left_child, values, &block)
    preorder(node.right_child, values, &block)
  
    values
  end

  def postorder(node = @root, values = [], &block)
    return values if node.nil?
  
    postorder(node.left_child, values, &block)
    postorder(node.right_child, values, &block)
    if block_given?
      yield(node)
    else
      values << node.data
    end
  
    values
  end

  def height(node)
    return -1 if node.nil?

    left_height = height(node.left_child)
    right_height = height(node.right_child)

    1 + [left_height, right_height].max

  end

  def depth(node)
    depth_count = 0
  
    while node != @root
      node = parent_of(node)
      depth_count += 1
    end
  
    depth_count
  end

  def parent_of(child, node = @root)
    return nil if node.nil? || node == child

    if node.left_child == child || node.right_child == child
      node
    else
      parent_of(child, node.left_child) || parent_of(child, node.right_child)
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left_child)
    right_height = height(node.right_child)

    # check balance for current node and recursively for subtrees
    (left_height - right_height).abs <= 1 && balanced?(node.left_child) && balanced?(node.right_child)
  end

  def rebalance
    sorted_values = inorder
    @root = build_tree(sorted_values)
  end


end
