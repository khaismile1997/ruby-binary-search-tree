require_relative 'node.rb'
require_relative 'tree.rb'

array = Array.new(15) {rand(1..100)}
bst = Tree.new(array)
puts "\n\n"
bst.pretty_print

puts bst.balanced? ? 'Your BST is balanced!' : 'Your BST is not balanced.'

puts 'Level order traversal: '
p bst.level_order

puts 'Preorder traversal: '
p bst.preorder

puts 'Inorder traversal: '
p bst.inorder

puts 'Postorder traversal: '
p bst.postorder

10.times do
  a = rand(100..150)
  bst.insert(a)
  puts "Insert #{a} into your BST!"
end

bst.pretty_print
puts "\n\n"
puts bst.balanced? ? 'Your BST is balanced!' : 'Your BST is not balanced.'

puts 'Rebalancig tree...'
bst.rebalance
bst.pretty_print
puts "\n\n"
puts bst.balanced? ? 'Your BST is balanced!' : 'Your BST is not balanced.'

puts 'Level order traversal: '
p bst.level_order

puts 'Preorder traversal: '
p bst.preorder

puts 'Inorder traversal: '
p bst.inorder

puts 'Postorder traversal: '
p bst.postorder
