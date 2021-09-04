require_relative "node.rb"
require "pry-byebug"

class Tree
  attr_reader :root#, :inorder_successor_parent

  def initialize(arr)
    arr = arr.uniq.sort
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
  end

  def insert(value)
    unless @root
      @root = Node.new(value)
      return
    end

    node = Node.new(value)
    curr = @root
    while curr
      if node < curr
        if curr.left
          curr = curr.left
        else
          curr.left = node
        end
      elsif node > curr
        if curr.right
          curr = curr.right
        else
          curr.right = node
        end
      else
        return
      end
    end
  end

  def delete(value)
    #cases:
    #del_node has no children
    #del_node has 1 child
    #del node has 2 children
    #inorder_successor has no children
    #inorder_successor has 1 child
    node = find(value)
    if node
      if node.leaf?
      elsif node.left

      elsif node.right

      else #two children
        successor_parent = inorder_successor_parent(node)
        successor = successor_parent.left
        if successor.leaf?
          node.data = successor.data
          successor_parent.left = nil
        else

        end
      end
    end
  end

  def level_order
    output = []
    queue = [@root]
    until queue.empty?
      curr = queue.shift
      output << curr
      queue << curr.left if curr.left
      queue << curr.right if curr.right
    end
    output
  end

  def find(value)
    curr = @root
    while curr
      return curr if curr.data == value

      if value < curr.data
        curr = curr.left
      elsif value > curr.data
        curr = curr.right
      end
    end
    curr
  end

  private

  def build_tree(arr, start_index = 0, end_index = arr.length - 1)
    return nil if start_index > end_index

    mid = (start_index + end_index) / 2
    curr_root = Node.new(arr[mid])
    curr_root.left = build_tree(arr, start_index, mid - 1)
    curr_root.right = build_tree(arr, mid + 1, end_index)
    curr_root
  end

  def parent(node)
    return nil if node == @root

    curr = @root
    parent = nil
    while curr
      return parent if node == curr

      if node < curr
        parent = curr
        curr = curr.left
      elsif node > curr
        parent = curr
        curr = curr.right
      end
    end
    nil
  end

  def inorder_successor_parent(node)
    return nil unless node.right

    curr = node.right
    parent = node
    while curr.left
      parent = curr
      curr = curr.left
    end
    parent
  end
end
