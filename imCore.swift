import Foundation

public struct IMCore {

  public static func run(_ graph: Graph) -> [Int] {
    var mutGraph = graph

    var results = [Int](repeating: 0, count: mutGraph.vertices.count)

    while !mutGraph.empty {
      let k = mutGraph.minDegree

      while mutGraph.vertexFor(degree: k) != -1 {

        let v = mutGraph.vertexFor(degree: k)

        results[v] = k

        // Check for possibly missing vertices due to removing incident edge
        let missing = mutGraph.delete(vertex: v)
        if !missing.isEmpty {
          missing.forEach { results[$0] = k }
        }
      }
    }
    return results
  }
}
