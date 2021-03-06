# Tool to create graphs

$univ_path = "graphs/"

def createPath(size)
  puts "Creating path of size: #{size}"
  name = $univ_path + "pathSuite/path_#{size}.txt"
  File.open(name, 'w') { |f|
    f.write("#{size}\n")
    f.write("#{size.to_i+1}\n")
    0.upto(size.to_i-1).each { |x| f.write("#{x} #{x+1}\n") }
  }
end

def createUDPath(size)
  puts "Creating undirected path of size: #{size}"
  name = $univ_path + "pathSuite/path_#{size}.txt"
  File.open(name, 'w') { |f|
    f.write("#{2*size.to_i}\n")
    f.write("#{size.to_i+1}\n")
    0.upto(size.to_i-1).each { |x|
      f.write("#{x} #{x+1}\n")
      f.write("#{x+1} #{x}\n")
    }
  }
end

def createGraph(size)
  puts "Creating graph of size: #{size}"
  name = $univ_path + "graph_#{size}.txt"
  File.open(name, 'w') { |f|
    f.write("#{size}\n")
    0.upto(size.to_i-1).each { |x|
      # Each vertex connects to itself and next one in sequence
      f.write("#{x} #{x}\n")
      f.write("#{x} #{x+1}\n")
    }
  }
end

def createMaxGraph(size)
  puts "Creating maximally connected graph of size: #{size}"
  name = $univ_path + "graph_max_#{size}.txt"
  File.open(name, 'w') { |f|
    f.write("#{size}\n")
    0.upto(size.to_i-1).each { |x|
      0.upto(size.to_i-1).each { |y|
        f.write("#{x} #{y}\n")
      }
    }
  }
end

# Undirected graphs
def createGraphNeighborsUndirected(size, nbr)
  puts "Creating undirected graph of size: #{size} with #{nbr} neighbors per vertex"
  name = $univ_path + "udSuite/#{size}_#{nbr}nbr_ud.txt"
  temp = "temp.txt"

  edges = 0
  File.open(temp, 'w') { |f|
    f.write("#{size}\n")
    0.upto(size.to_i-1).each { |x|
      x.upto(nbr.to_i-1).each { |y|
        f.write("#{x} #{y}\n")
        edges += 1
        if x != y
          f.write("#{y} #{x}\n")
          edges += 1
        end
      }
    }
  }
  File.open(name, 'w') do |f|
    f.write("#{edges}\n")
    File.foreach(temp) do |line|
      f.write(line)
    end
  end

  File.delete(temp)
end


if ARGV[0] && ARGV[0] == "pathSuite"
  puts "Create default paths (undirected):"
  (1...14).each do |n|
    createUDPath(2**n)
  end
else
  if ARGV.length == 0 || (ARGV[0] && ARGV[0] == "default")
    if ARGV[1]
      puts "Create default graph (undirected) with size: #{ARGV[1]}"
      createGraphNeighborsUndirected(ARGV[1], ARGV[1])
    else
      puts "Create default graphs (undirected):"
      (1...14).each do |n|
        createGraphNeighborsUndirected(2**n, 2**n)
      end
    end
  else
    size = ARGV.length == 0 ? 10 : ARGV[0]
    type = (ARGV.length == 1 || ARGV[1] != "graph") ? "path" : ARGV[1]
    if ARGV[1] == "max"
      createMaxGraph(size)
    elsif ARGV[1] == "nbr"
      numNbr = ARGV[2] ? ARGV[2] : 10
      if ARGV[3] && ARGV[3] == "undirected"
        createGraphNeighborsUndirected(size, numNbr)
      end
    else
      type == "path" ? createPath(size) : createGraph(size)
    end
  end
end
