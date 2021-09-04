class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end

  def to_s
    @data.to_s
  end

  def leaf?
    !left && !right
  end
end