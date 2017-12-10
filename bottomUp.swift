import Foundation

public struct BottomUp {

  public static func run(_ graph: Graph) -> [[Int]] {
    var io = 0

    var mutGraph = graph
    // print("Graph before sorting: \(mutGraph)")

    // ascending order of their degree
    // mutGraph.sorted()


    // Vertices in ascending order by degree
    var vertices = mutGraph.vertices.sorted { left, right in
      graph.vertexDegree(left) < graph.vertexDegree(right)
    }
    // print("VERTICES: \(vertices)")

    var results = [[Int]](repeating: [], count: mutGraph.maxDegree()+1)

    while !mutGraph.empty {
      // print("-- NOT EMPTY: \(mutGraph)")
      io += 1
      let d = mutGraph.minDegree()
      // print("MIN: \(d)")
      while mutGraph.vertexWith(degree: d) {
        // print("---- VERTEX WITH DEGREE \(d): \(mutGraph)")
        // let v = mutGraph.nextVertex
        let v = vertices.removeFirst()
        // print("---- VERTICES: \(vertices)")
        results[d].append(v)
        mutGraph.delete(vertex: v)
        // mutGraph.sorted()
        vertices = vertices.sorted { left, right in
          graph.vertexDegree(left) < graph.vertexDegree(right)
        }
        // print("---- VERTICES: \(vertices)")
        // print("---- AFTER CHANGES: \(mutGraph)")
      }
    }

    // print("Min Degree: \(mutGraph.minDegree())")
    // print("Max Degree: \(mutGraph.maxDegree())")
    print("- BottomUp -- I/O's: \(io)\n")
    return results
  }
}
