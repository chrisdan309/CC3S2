def letraFaltante(cad)
  cad = cad.downcase
  for letra in 'a'..'z'
    return letra if !cad.include?(letra)
  end
end


cadena = "the quick brown box jumps over a lazy dog"
letraFalta = letraFaltante(cadena)
puts "La letra que falta es #{letraFalta}"
