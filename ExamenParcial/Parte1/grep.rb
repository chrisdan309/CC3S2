argc = ARGV.length

arguments = []
filesName = []
cad = ARGV[0]
for i in 1..argc-1
    if ARGV[i][0] == "-"
        command = ARGV[i][1..-1]
        arguments.push(command)
    elsif ARGV[i][0] == ":"
        fileName = ARGV[i][1..-1]
        filesName.push(fileName)
    else
        raise "Argumento incorrecto"
        Fail
    end
end

if filesName.empty?
    raise "No hay archivo para leer"
    Fail
end

filesName.each do |fileName|
    file = File.open(fileName, "r")
    file.each_line do |line|
        if !arguments.empty?
            if arguments.include?("n")
                if line.include?(cad)
                    puts "#{fileName} #{file.lineno}: #{line}"
                end
            end
            
            if arguments.include?("l")
                if line.include?(cad)
                    puts fileName
                    break
                end
            end

            if arguments.include?("i")
                if line.downcase.include?(cad.downcase)
                    puts line
                end
            end

            if arguments.include?("v")
                if !line.include?(cad)
                    puts line
                end
            end
            
            if arguments.include?("x")
                if line == cad
                    puts line
                end
            end

        else
            if line.include?(cad)
                puts line
            end
        end
    end

    file.close
end


