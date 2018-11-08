# frozen_string_literal: true

# Binary Search Tree
#            Average     Worst case
# Space        O(n)         O(n)
# Search     O(log n)       O(n)
# Insert     O(log n)       O(n)
# Delete     O(log n)       O(n)
#
class Tree
  attr_reader :root, :size

  def initialize(value)
    @root = Node.new(value)
    @size = 1
  end

  def insert(value)
    @size += 1
    insert_rec(Node.new(value), @root)
  end

  def delete(value)
    node = search_rec(Node.new(value), @root)
    return if node.nil?

    if node.left.nil? && node.right.nil?
      delete_leaf(node)
    elsif node.right.nil?
      delete_right(node)
    elsif node.left.nil?
      delete_left(node)
    else
      delete_both(node)
    end
    @size -= 1
    node
  end

  def search(value)
    search_rec(Node.new(value), @root)
  end

  def inorder(node = @root)
    @stack = [] if node == root
    return if node.nil?

    inorder(node.left)
    @stack << node.data
    inorder(node.right)
    @stack
  end

  def preorder(node = @root)
    return if node.nil?

    @stack = [] if node == root
    @stack << node.data
    inorder(node.left)
    inorder(node.right)
    @stack
  end

  def postorder(node = @root)
    return if node.nil?

    @stack = [] if node == root
    inorder(node.left)
    inorder(node.right)
    @stack << node.data
    @stack
  end

  private

  attr_accessor :stack, :parent

  def insert_rec(node, current)
    case current <=> node
    # node.data == current.data
    when 0
      nil
    # node.data > current.data
    when 1
      return current.left = node if current.left.nil?

      insert_rec(node, current.left)
    # node.data > current.data
    when -1
      return current.right = node if current.right.nil?

      insert_rec(node, current.right)
    end
  end

  def search_rec(node, current)
    return nil if node.nil?

    case current <=> node
    # node.data == current.data
    when 0
      return current
    # node.data > current.data
    when 1
      @parent = current
      search_rec(node, current.left)
    # node.data > current.data
    when -1
      @parent = current
      search_rec(node, current.right)
    end
  end

  def leftmost(node)
    return node if node.left.nil?

    leftmost(node.left)
  end

  def delete_both(node)
    replacement = leftmost(node)
    search_rec(replacement, @root)
    node.data = replacement.data
    @parent.left = replacement.right
  end

  def delete_leaf(node)
    return @parent.right = nil if @parent.right == node

    @parent.left = nil
  end

  def delete_right(node)
    return @parent.right = node.left if @parent.right == node

    @parent.left = node.left
  end

  def delete_left(node)
    return @parent.right = node.right if @parent.right == node

    @parent.left = node.right
  end
end
