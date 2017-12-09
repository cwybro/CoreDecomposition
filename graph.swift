import Foundation

public struct Graph {
    public var adjList: [[Int]]

    public enum RunType {
    case semiCore, bottomUp
    }

    public var size: Int {
        return adjList.count
    }

    public var empty: Bool {
      var empty = true

      adjList.forEach { arr in
        if !arr.isEmpty {
          empty = false
        }
      }
      return empty
    }

    public var nextVertex: Int {
      var v = 0
      for (index, arr) in adjList.enumerated() {
          if !arr.isEmpty {
              v = index
              break
          }
      }
      return v
    }

    // Convenience init with filename
    public init(fileName: String) {
        adjList = []
        if let result = FileReader.read(fileName) {
            adjList = Array(repeating: [], count: result.points+1)
            result.tuples.forEach { addEdge(from: $0.0, to: $0.1) }
        }
        print("Loaded graph of size: \(size)\n")
    }

    public mutating func addEdge(from source: Int, to destination: Int) {
        adjList[source] = adjList[source] + [destination]
    }
}

// MARK: - Helper methods
extension Graph {
  public func vertexNum() -> Int {
    return self.size
  }

  public func maxDegree() -> Int {
    var max = 0
    adjList.forEach { neighbors in
      if neighbors.count > max {
        max = neighbors.count
      }
    }
    return max
  }

  public func minDegree() -> Int {
    var min = maxDegree()
    adjList.forEach { neighbors in
      if neighbors.count < min {
        min = neighbors.count
      }
    }
    return min
  }

  public func vertexDegree(_ vertex: Int) -> Int {
    return adjList[vertex].count
  }

  public func neighbors(_ vertex: Int) -> [Int] {
    return adjList[vertex]
  }

  public mutating func sorted() {
    adjList.sort { $0.count < $1.count }
  }

  public func vertexListSortedByDegree() -> [Int] {
    let vertices = Array(0..<adjList.count)
    return vertices.sorted { vertexDegree($0) < vertexDegree($1) }
  }

  public func vertexWith(degree: Int) -> Bool {
    var present = false
    adjList.forEach {
      if $0.count <= degree {
        present = true
      }
    }
    return present
  }

  // Removes vertex & all edges incident to vertex
  public mutating func delete(vertex: Int) {
    adjList.remove(at: vertex)

    for (index, arr) in adjList.enumerated() {
        let newArr = arr.filter { $0 != vertex }
        adjList[index] = newArr
    }
  }
}

// MARK: - Solutions
extension Graph {
    // MARK: Core Decomposition
    public func kCore(type: RunType) -> [Int] {
        switch type {
        case .semiCore: return SemiCore.run(self)
        case .bottomUp:
          let result = BottomUp.run(self)
          print("RESULT: \(result)")
          return result.normalizeOutput()
        }
    }
}

// MARK: - Helper for BottomUp algorithm
extension Array where Element == [Int] {
    func normalizeOutput() -> [Int] {
        let max = self.flatMap { $0}.max()!
        var result = [Int](repeating: 0, count: max+1)

        for (index, internalArr) in self.enumerated() {
            for num in internalArr {
                result[num] = index
            }
        }

        return result
    }
}
