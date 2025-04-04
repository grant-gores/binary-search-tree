require_relative './lib/tree.rb'

# Step 1: Create a binary search tree from an array of random numbers
random_array = Array.new(15) { rand(1..100) }
tree = Tree.new(random_array)

# Step 2: Confirm the tree is balanced
puts "Is the tree balanced? #{tree.balanced?}"

# Step 3: Print all elements in level, pre, post, and in order
puts "Level-order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"

# Step 4: Unbalance the tree by adding several numbers > 100
[101, 102, 103, 104, 105].each { |value| tree.insert(value) }

# Step 5: Confirm the tree is unbalanced
puts "Is the tree balanced after adding nodes? #{tree.balanced?}"

# Step 6: Balance the tree
tree.rebalance

# Step 7: Confirm the tree is balanced again
puts "Is the tree balanced after rebalancing? #{tree.balanced?}"

# Step 8: Print all elements again in level, pre, post, and in order
puts "Level-order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"