require_relative "node.rb"

class Tree
  attr_reader :root

  def initialize(arr)
    arr = arr.uniq.sort
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def build_tree(arr, start_index = 0, end_index = arr.length-1)
    return nil if start_index > end_index

    mid = (start_index + end_index) / 2
    curr_root = Node.new(arr[mid])
    curr_root.left = build_tree(arr, start_index, mid - 1)
    curr_root.right = build_tree(arr, mid + 1, end_index)
    curr_root
  end


end