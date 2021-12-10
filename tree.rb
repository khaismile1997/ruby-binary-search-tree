require "active_support/all"

class Tree
  attr_accessor :root, :data
  def initialize(data)
    @data = data.sort.uniq
    @root = build_tree(@data)
  end

  def build_tree(data)
    return if data.empty?
    return Node.new(data.first) if data.length == 1

    mid = data.length / 2
    root_node = Node.new(data[mid])
    root_node.left_node = build_tree(data[0...mid])
    root_node.right_node = build_tree(data[(mid+1)..-1])

    root_node
  end
  
  def insert(value, node = root)
    return if value.eql? node.data

    if value < node.data
      node.left_node.nil? ? node.left_node = Node.new(value) : insert(value, node.left_node)
    else
      node.right_node.nil? ? node.right_node = Node.new(value) : insert(value, node.right_node)
    end
  end
  
  def delete(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left_node = delete(value, node.left_node)
    elsif value > node.data
      node.right_node = delete(value, node.right_node)
    else
      return node.left_node if node.right_node.nil?
      return node.right_node if node.left_node.nil?

      left_most_node = left_most_node(node.right_node)
      node.data = left_most_node.data
      node.right_node = delete(left_most_node.data, node.right_node)
    end
    node
  end

  def find(value, node = root)
    return node if node.nil? || node.data == value
    value > node.data ? find(value, node.right_node) : find(value, node.left_node)
  end

  def level_order(node = root, queue = [], result = [])
    result.push(node.data)
    queue.push(node.left_node) unless node.left_node.nil?
    queue.push(node.right_node) unless node.right_node.nil?
    return if queue.empty?
    level_order(queue.shift, queue, result)
    result
  end
  
  def preorder(node = root, result = [])
    return if node.nil?
    result.push(node.data)
    preorder(node.left_node, result)
    preorder(node.right_node, result)
    result
  end

  def inorder(node = root, result = [])
    return if node.nil?
    inorder(node.left_node, result)
    result.push(node.data)
    inorder(node.right_node, result)
    result
  end

  def postorder(node = root, result = [])
    return if node.nil?
    postorder(node.left_node, result)
    postorder(node.right_node, result)
    result.push(node.data)
    result
  end

  def height(node = root)
    return -1 if node.nil?

    if node.present? && node.data != root
      node = node.instance_of?(Node) ? find(node.data) : find(node)
    end

    [height(node.left_node), height(node.right_node)].max + 1
  end

  def depth(node = root, parent = root, edges = 0)
    return 0 if node == parent.data
    return -1 if node.nil?

    if node < parent.data
      edges += 1
      depth(node, parent.left_node, edges)
    elsif node > parent.data
      edges += 1
      depth(node, parent.right_node, edges)
    else
      edges
    end
  end

  def balanced?(node = root)
    return true if node.nil?

    left_height = height(node.left_node)
    right_height = height(node.right_node)

    return true if (left_height - right_height).abs <= 1 &&
                    balanced?(node.left_node) &&
                    balanced?(node.right_node)
    false
  end
  
  def rebalance
    self.data = inorder
    self.root = build_tree(data)
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
  
  private
  def left_most_node(node)
    node = node.left_node until node.left_node.nil?
    node
  end
end