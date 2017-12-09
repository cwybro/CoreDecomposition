import Foundation

public struct Graph {
    public var adjList: [[Int]]

    public enum RunType {
      case semiCore
    }

    public var size: Int {
        return adjList.count
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
  public func getVertexNum() -> Int {
    return self.size
  }

  public func getMaxDegree() -> Int {
    var max = 0
    adjList.forEach { neighbors in
      if neighbors.count > max {
        max = neighbors.count
      }
    }
    return max
  }

  public func getVertexDegree(_ vertex: Int) -> Int {
    return adjList[vertex].count
  }

  public func getNeighbors(_ vertex: Int) -> [Int] {
    return adjList[vertex]
  }
}

// MARK: - Solutions
extension Graph {
    // MARK: Core Decomposition
    public func kCore(type: RunType) -> [Int] {
        switch type {
        case .semiCore: return SemiCore.run(self)
        }
    }
}
