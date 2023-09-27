# Parte 1

def sum arr
  if arr.length == 0
    return 0
  else
    suma = 0
    arr.each do |i|
      suma += i
    end
    return suma
  end
end

def max_2_sum arr
  if arr.length == 0
    return 0
  else
    if arr.length == 1
      return arr[0]
    else
      arr.sort!
      return arr[-1] + arr[-2]
    end
  end
end

def sum_to_n? arr, n
  if arr.length == 0
    return false
  else
    if arr.length == 1
      return false
    else
      arr.sort!
      i = 0
      j = arr.length - 1
      while i < j
        if arr[i] + arr[j] == n
          return true
        else
          if arr[i] + arr[j] < n
            i += 1
          else
            j -= 1
          end
        end
      end
      return false
    end
  end
end

# Parte 2

def hello(name)
  "Hello, " + name
end

def starts_with_consonant? s
  s = s.downcase
  if s.length == 0
    return false
  else
    if s[0] =~ /[bcdfghjklmnpqrstvwxyz]/
      return true
    else
      return false
    end
  end
end

def binary_multiple_of_4? s
  if s.length == 0
    return false
  else
    if s =~ /^[0-1]+$/
      if s.to_i(2) % 4 == 0
        return true
      else
        return false
      end
    else
      return false
    end
  end
end

# Parte 3

class BookInStock
  attr_accessor :isbn, :price

  def initialize(isbn, price)
    if isbn.length == 0 || price <= 0
      raise ArgumentError
    else
      @isbn = isbn
      @price = price
    end
  end

  def isbn
    @isbn
  end

  def isbn=(isbn)
    @isbn = isbn
  end

  def price
    @price
  end

  def price=(price)
    @price = price
  end
  
  def price_as_string
    "$%.2f" % @price
  end

end
