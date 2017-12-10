import Foundation

public struct Graph {
    public var adjList: [[Int]]

    public enum RunType {
    case semiCore, imCore
    }

    public var edges: Int {
      return adjList.count
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

    public var minDegree: Int {
      var min = maxDegree()
      adjList.forEach { neighbors in
        if neighbors.count < min && !neighbors.isEmpty {
          min = neighbors.count
        }
      }
      return min
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

    public var vertices: [Int] {
      return Array(0..<adjList.count)
    }

    // Convenience init with filename
    public init(fileName: String) {
        adjList = []
        if let result = FileReader.read(fileName) {
            adjList = Array(repeating: [], count: result.vertices)
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

  public func vertexDegree(_ vertex: Int) -> Int {
    return adjList[vertex].count
  }

  public func neighbors(_ vertex: Int) -> [Int] {
    return adjList[vertex]
  }

  public mutating func sorted() {
    adjList.sort { $0.count < $1.count }
  }

  public func vertexWith(degree: Int) -> Bool {
    if empty {
      return false
    }

    guard !empty else { return false }

    var present = false
    adjList.forEach {
      if $0.count <= degree {
        present = true
      }
    }
    return present
  }

  public func vertexFor(degree: Int) -> Int {
    if empty  {
      return -1
    }

    var vertex = -1
    for (index, arr) in adjList.enumerated() {
      if arr.count <= degree && !arr.isEmpty {
        vertex = index
        break
      }
    }

    return vertex
  }

  // Removes vertex & all edges incident to vertex
  // Returns possibly missing vertices due to removing incident edge
  @discardableResult
  public mutating func delete(vertex: Int) -> [Int] {
    guard !adjList[vertex].isEmpty else { return [] }

    adjList[vertex] = []

    var missing = [Int]()

    for (index, arr) in adjList.enumerated() {
        let newArr = arr.filter { $0 != vertex }
        adjList[index] = newArr
        if newArr.isEmpty && arr != newArr { missing.append(index) }
    }

    let flat = adjList.flatMap { $0 }
    if flat.isEmpty {
      return missing
    }
    return []
  }
}

// MARK: - Solutions
extension Graph {
    // MARK: Core Decomposition
    @discardableResult
    public func kCore(type: RunType) -> [Int] {
        switch type {
        case .semiCore: return SemiCore.run(self)
        case .imCore: return IMCore.run(self)
        }
    }
}
