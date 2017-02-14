class Node
  attr_accessor :value, :parent, :left, :right

  def initialize(v=nil, par=nil, left=nil, right=nil)
    @value = v
    @parent = par
    @left = left
    @right = right
  end

  def to_s(cr="")
    string = ''
    string << "#{cr}\u221F> #{self.value}\n"
    string << self.left.to_s(cr + "   ") if self.left
    string << self.right.to_s(cr + "   ") if self.right
    
    return string
  end
  
end

def binary_tree(ary=[], parent=nil)
  return nil if ary.empty?

  mid_i = ary.size / 2
  value = ary[mid_i]
  aryl = left(ary, mid_i)
  aryr = right(ary, mid_i)

  node = Node.new(value, parent)
  node.left = binary_tree(aryl, node)
  node.right = binary_tree(aryr, node)
  return node
end

def binary_search_tree(ar=[], parent=nil)
  ary = ar.shuffle
  if parent == nil && !ary.empty?
    node = Node.new(ary.slice!(rand(ary.size)), parent)
    return binary_search_tree(ary, node)
  end

  ary.each do |e|
    insert_in_bst(e,parent)
  end

  return parent
end 

def breadth_first_search(value, node)
  queue = [node]

  until queue.empty?
    tmp = queue.shift
    queue << tmp.left if tmp.left
    queue << tmp.right if tmp.right

    return tmp if tmp.value == value
  end
  
  return nil
end

def depth_first_search(value, node)
  stack = [node]
  visited = {}

  until stack.empty?
    tmp = stack.last
    return tmp if value == tmp.value

    puts ">#{tmp.value}<"
    visited[tmp] = true

    left = tmp.left
    right = tmp.right

    if (((left && visited[left]) || !left) && ((right && visited[right]) || !right))
      stack.pop
    end

    stack << right if right && !visited[right]
    stack << left if left && !visited[left]
  end
  
  return nil
end
      
def dfs_rec(value, node)
  return nil if node.nil?
  return node if value == node.value

  match_left = dfs_rec(value, node.left)
  return match_left unless match_left.nil?

  match_right = dfs_rec(value, node.right)
  return match_right 
end

# HELPERS
def insert_in_bst(e, parent)
    if e <= parent.value
      if parent.left == nil
        parent.left = Node.new(e, parent) 
      else
        insert_in_bst(e, parent.left)
      end
    end
    
    if e > parent.value
      if parent.right == nil
        parent.right = Node.new(e, parent)
      else
        insert_in_bst(e, parent.right)
      end
    end
end

def left(ary,index)
  aryl = []
  ary.each_with_index { |e, i| aryl << e if i < index }
  return aryl
end

def right(ary,index)
  aryr = []
  ary.each_with_index { |e, i| aryr << e if i > index }
  return aryr
end
