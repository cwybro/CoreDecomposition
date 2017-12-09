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

def createGraph10Neighbors(size)
  if size.to_i >= 10
    puts "Creating graph of size: #{size} with 10 neighbors per vertex"
    name = $univ_path + "graph_nbr10_#{size}.txt"
    File.open(name, 'w') { |f|
      f.write("#{size}\n")
      0.upto(size.to_i-1).each { |x|
        0.upto(10-1).each { |y|
          f.write("#{x} #{y}\n")
        }
      }
    }
  else
    puts "Size must be at least 10"
  end
end

size = ARGV.length == 0 ? 10 : ARGV[0]
type = (ARGV.length == 1 || ARGV[1] != "graph") ? "path" : ARGV[1]
if ARGV[1] == "max"
  createMaxGraph(size)
elsif ARGV[1] == "nbr"
  createGraph10Neighbors(size)
else
  type == "path" ? createPath(size) : createGraph(size)
end
