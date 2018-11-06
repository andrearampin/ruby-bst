# frozen_string_literal: true

# Binary Search Node
class Node
  include Enumerable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
  end

  def <=>(other)
    data <=> other.data
  end
end
