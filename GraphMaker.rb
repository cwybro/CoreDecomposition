# Tool to create graphs

$univ_path = "graphs/"

def createPath(size)
  puts "Creating path of size: #{size}"
  name = $univ_path + "path_#{size}.txt"
  File.open(name, 'w') { |f|
    f.write("#{size}\n")
    0.upto(size.to_i-1).each { |x| f.write("#{x} #{x+1}\n") }
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
  name = $univ_path + "#{size}_#{nbr}nbr_ud.txt"
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

if ARGV.length == 0 || (ARGV[1] && ARGV[1] == "default")
  puts "Create default graphs (undirected):"
  createGraphNeighborsUndirected(1, 1)
  createGraphNeighborsUndirected(2, 2)
  createGraphNeighborsUndirected(4, 4)
  createGraphNeighborsUndirected(8, 8)
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
