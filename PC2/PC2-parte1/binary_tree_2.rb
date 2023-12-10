# Create a class binarytree2 that extends binarytree
# and overwrite the include? method to use a block
# instead of a value to search

require_relative 'binary_tree'

class BinaryTree2 < BinaryTree
    def initialize()
        super()
    end

    def include?(element, &block)
        each {|x| return true if block.call(x, element)}
        return false
        
    end


    def all?(&block)
        each {|x| return false unless block.call(x, @valor)}
        return true
    end

    def any?(&block)
        each {|x| return true if block.call(x, @valor)}
        return false
    end

    def sort(&block)
        array = []
        each {|x| array << x}
        array.sort(&block)
    end
end


tree = BinaryTree2.new
tree << 10
tree << 1
tree << 15
tree << 3

puts tree.each {|x| puts x}
element = 3
puts tree.include?(element) {|x| x == element}

puts tree.all? {|x| x > 0}

puts tree.any? {|x| x == 3}

puts tree.sort {|x, y| y <=> x}