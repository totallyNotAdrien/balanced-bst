require_relative "tree.rb"

range = 1..25
tree = Tree.new(Array.new(30) { rand(range) })

puts "Tree:"
tree.pretty_print

puts
puts "level order: #{tree.level_order.map { |elem| elem.data }}"
puts

5.times do
  num = rand(range)
  node = tree.find(num)
  puts "find #{num}: #{node ? "found it" : "nope"}"
end

nums = Array.new(5) { rand(range) }
nums.each { |num| tree.insert(num) }
puts "tree after inserting #{nums.join(", ")}:"
tree.pretty_print
