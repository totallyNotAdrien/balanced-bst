require_relative "node.rb"

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

  def delete(value)
    del_node = find(value)

    if del_node
      parent = parent_node(del_node)

      if del_node.leaf? #no children
        if del_node.equal?(parent.left)
          parent.left = nil
        else
          parent.right = nil
        end
      elsif del_node.left && !del_node.right #one child
        if del_node.equal?(parent.left)
          parent.left = del_node.left
        elsif del_node.equal?(parent.right)
          parent.right = del_node.left
        end
      elsif del_node.right && !del_node.left #one child
        if del_node.equal?(parent.left)
          parent.left = del_node.right
        elsif del_node.equal?(parent.right)
          parent.right = del_node.right
        end
      else #two children
        succ_node = successor(del_node)
        temp = succ_node.data
        delete(succ_node.data)
        del_node.data = temp
      end
    end
  end

  #returns a node with the given value if it exists in the tree
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

  def level_order
    output = []
    queue = [@root]
    until queue.empty?
      curr = queue.shift
      output << curr.data
      queue << curr.left if curr.left
      queue << curr.right if curr.right
    end
    output
  end

  def inorder(curr = @root)
    return [] unless curr

    arr = []
    arr = arr + inorder(curr.left) if curr.left
    arr << curr.data
    arr = arr + inorder(curr.right) if curr.right
    arr
  end

  def preorder(curr = @root)
    return [] unless curr

    arr = []
    arr << curr.data
    arr = arr + preorder(curr.left) if curr.left
    arr = arr + preorder(curr.right) if curr.right
    arr
  end

  def postorder(curr = @root)
    return unless curr

    arr = []
    arr = arr + postorder(curr.left) if curr.left
    arr = arr + postorder(curr.right) if curr.right
    arr << curr.data
    arr
  end

  def height(node)
    return 0 unless node
    return -1 unless find(node.data)
    return 0 if node.leaf?

    right_height = nil
    left_height = nil

    if node.right
      right_height = 1 + height(node.right)
    end
    if node.left
      left_height = 1 + height(node.left)
    end
    right_height = 0 unless right_height
    left_height = 0 unless left_height

    right_height > left_height ? right_height : left_height
  end

  def depth(node)
    return -1 unless node
    return -1 unless find(node.data)
    return 0 if node.equal?(@root)

    curr = @root
    deep = 0
    while curr
      return deep if curr.equal?(node)

      if node < curr
        deep += 1
        curr = curr.left
      elsif node > curr
        deep += 1
        curr = curr.right
      end
    end
    nil
  end

  def balanced?(curr_root = @root)
    return true unless curr_root

    left_height = height(curr_root.left)
    right_height = height(curr_root.right)
    acceptable_height_diff = (left_height - right_height).abs <= 1

    acceptable_height_diff &&
    balanced?(curr_root.left) &&
    balanced?(curr_root.right)
  end

  def rebalance
    arr = inorder
    @root = build_tree(arr)
  end

  private

  #takes a sorted array and returns the root node of a 
  #balanced bst created from the array
  #given an unsorted array, returns root of unbalanced bst
  def build_tree(arr, start_index = 0, end_index = arr.length - 1)
    return nil if start_index > end_index

    mid = (start_index + end_index) / 2
    curr_root = arr[mid].is_a?(Node) ? arr[mid] : Node.new(arr[mid])
    curr_root.left = build_tree(arr, start_index, mid - 1)
    curr_root.right = build_tree(arr, mid + 1, end_index)
    curr_root
  end

  def parent_node(node)
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

  def successor(predecessor)
    curr = predecessor.right
    while curr && curr.left
      curr = curr.left
    end

    curr = predecessor unless curr
    curr
  end
end
