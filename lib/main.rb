require_relative "tree.rb"

range = 1..100
tree = Tree.new(Array.new(40) { rand(range) })
test_arr = [51, 21, 79, 11, 34, 68, 91, 7, 14, 28, 40, 62, 74,
            87, 97, 6, 9, 13, 18, 27, 30, 39, 48, 60, 64, 72, 
            76, 85, 90, 96, 99, 49, 100]

tree = Tree.new(test_arr)

puts "Tree:"
tree.pretty_print
puts

level_order = tree.level_order
puts "level order: #{level_order.map { |elem| elem.data }}"
puts

puts "Tree after deleting 49:"
tree.delete(49)
tree.pretty_print
puts

5.times do
  num = rand(range)
  node = tree.find(num)
  puts "find #{num}: #{node ? "found it" : "nope"}"
end
puts

nums = Array.new(5) { rand(range) }
nums.each { |num| tree.insert(num) }
puts "tree after inserting #{nums.join(", ")}:"
tree.pretty_print
