require_relative "node.rb"
require "pry-byebug"

class Tree
  attr_reader :root

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
end
