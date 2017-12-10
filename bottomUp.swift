import Foundation

public struct BottomUp {

  public static func run(_ graph: Graph) -> [[Int]] {
    // var io = 0

    var mutGraph = graph

    var vertices = mutGraph.vertices.sorted { left, right in
      graph.vertexDegree(left) < graph.vertexDegree(right)
    }

    var results = [[Int]](repeating: [], count: mutGraph.maxDegree()+1)

    while !mutGraph.empty {
      let d = mutGraph.minDegree

      while mutGraph.vertexWith(degree: d) {
        // io += 1
        let v = vertices.removeFirst()

        results[d].append(v)
        mutGraph.delete(vertex: v)

        vertices = vertices.sorted { left, right in
          graph.vertexDegree(left) < graph.vertexDegree(right)
        }
      }
    }
    // print("- BottomUp -- I/O's: \(io)\n")
    return results
  }
}
