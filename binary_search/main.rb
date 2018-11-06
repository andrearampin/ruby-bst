# frozen_string_literal: true

require_relative 'tree'
require_relative 'node'
require 'byebug'

values = [2, 3, 4, 5, 8, 76, 1, 23]

t = Tree.new(values.shift)
values.each { |val| t.insert(val) }
puts t.inorder.join(', ')
t.delete(23)
t.delete(2)
puts t.inorder.join(', ')
