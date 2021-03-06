import Foundation

public struct IMCore {

  public static func run(_ graph: Graph) -> [Int] {
    // print("IMCORE")
    let startMem = report_memory()

    var mutGraph = graph

    var results = [Int](repeating: 0, count: mutGraph.vertices.count)
    var vertices = Set<Int>()
    mutGraph.vertices.forEach { vertices.insert($0) }

    var finalDegree = mutGraph.minDegree

    while !mutGraph.empty {
      let k = mutGraph.minDegree
      finalDegree = k

      while mutGraph.vertexFor(degree: k) != -1 {

        let v = mutGraph.vertexFor(degree: k)

        results[v] = k
        mutGraph.delete(vertex: v)
        vertices.remove(v)
      }
    }

    // Check for possibly missing vertices due to removing incident edge
    if vertices.count > 0 {
      guard let vert = vertices.popFirst() else { return results }
      // let vert = vertices.popFirst()!
      results[vert] = finalDegree
    }

    print("MEM USED BY: IMCore -- \(report_memory() - startMem)")
    return results
  }
}
