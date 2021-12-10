class Node
  attr_accessor :data, :left_node, :right_node
  def initialize(data, left_node = nil, right_node = nil)
    @data = data
    @left_node = left_node
    @right_node = right_node
  end
end