class BinaryTree
  attr_accessor :valor, :izquierda, :derecha

  def initialize()
    @valor = nil
    @izquierda = nil
    @derecha = nil
  end

  def << (element)
    if @valor.nil?
      @valor = element
    elsif element <= @valor
      if @izquierda.nil?
        @izquierda = BinaryTree.new
      end
      @izquierda << element
    else
      if @derecha.nil?
        @derecha = BinaryTree.new
      end
      @derecha << element
    end
  end

  def empty?
    @valor.nil?
  end

  def each(&block)
    @izquierda.each(&block) unless @izquierda.nil?
    yield @valor
    @derecha.each(&block) unless @derecha.nil?
  end

end

arbol = BinaryTree.new
arbol << 5
arbol << 3
arbol << 7
arbol.each { |x| puts x*2 }
