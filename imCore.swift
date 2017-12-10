import Foundation

public struct IMCore {

  public static func run(_ graph: Graph) -> [Int] {
    var mutGraph = graph

    var results = [Int](repeating: 0, count: mutGraph.vertices.count)

    while !mutGraph.empty {
      var k = mutGraph.minDegree

      while mutGraph.vertexFor(degree: k) != -1 {

        let v = mutGraph.vertexFor(degree: k)

        results[v] = k
        mutGraph.delete(vertex: v)
      }
    }
    return results
  }
}
