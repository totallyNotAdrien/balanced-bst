require_relative "tree.rb"

tree = Tree.new(Array.new(30){rand(1..25)})

puts "Tree:"
tree.pretty_print

puts
puts "level order: #{tree.level_order.map{|elem| elem.data}}"