class BinaryTree
  attr_accessor :valor, :izquierda, :derecha

  def initialize()
    @valor = nil
    @izquierda = nil
    @derecha = nil
  end

  def << (elemento)
    if @valor.nil?
      @valor = elemento
    elsif elemento <= @valor
      @izquierda = BinaryTree.new
      @izquierda <<(elemento)
    else
      @derecha = BinaryTree.new
      @derecha <<(elemento)
    end
  end

  def empty?
    @valor.nil?
  end

  def each()
    pass
  end

end
