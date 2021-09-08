require_relative "tree.rb"

range = 1..100
range2 = 1..200
tree = Tree.new(Array.new(15) { rand(range) })

puts "Tree:"
tree.pretty_print
puts
puts "tree balanced?: #{tree.balanced?}"
puts

level_order = tree.level_order
puts "level order: #{level_order}"
puts

preorder = tree.preorder
puts "preorder: #{preorder}"
puts

postorder = tree.postorder
puts "postorder: #{postorder}"
puts

inorder = tree.inorder
puts "inorder: #{inorder}"
puts

nums = Array.new(10) { rand(range2) }
nums.each { |num| tree.insert(num) }
puts "tree after inserting #{nums.join(", ")}:"
tree.pretty_print
puts

puts "tree balanced?: #{tree.balanced?}"
puts
puts "tree after rebalancing:"
tree.rebalance
puts tree.pretty_print
puts
puts "tree balanced?: #{tree.balanced?}"
puts

level_order = tree.level_order
puts "level order: #{level_order}"
puts

preorder = tree.preorder
puts "preorder: #{preorder}"
puts

postorder = tree.postorder
puts "postorder: #{postorder}"
puts

inorder = tree.inorder
puts "inorder: #{inorder}"
puts