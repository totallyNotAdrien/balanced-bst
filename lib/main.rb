require_relative "tree.rb"

range = 1..100
tree = Tree.new(Array.new(40) { rand(range) })

puts "Tree:"
tree.pretty_print
puts

level_order = tree.level_order
puts "level order: #{level_order.map { |elem| elem.data }}"
puts

5.times do
  num = rand(range)
  node = tree.find(num)
  puts "find #{num}: #{node ? "found it" : "nope"}"
end
puts

#test inorder_successor_parent
#needs attr
# indices = Array.new(10) { rand(0...level_order.length) }.uniq
# values = indices.map { |i| level_order[i].data }
# puts "values to find the parent of the successor of: #{values}"
# values.each{|num| puts "parent of successor of #{num}: #{tree.inorder_successor_parent(tree.find(num))}"}
# puts

nums = Array.new(5) { rand(range) }
nums.each { |num| tree.insert(num) }
puts "tree after inserting #{nums.join(", ")}:"
tree.pretty_print
