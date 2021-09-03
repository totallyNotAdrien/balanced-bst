require_relative "tree.rb"

tree = Tree.new(Array.new(30){rand(1..25)})

tree.pretty_print