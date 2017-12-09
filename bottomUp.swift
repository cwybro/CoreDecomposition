import Foundation

public struct BottomUp {

  public static func run(_ graph: Graph) -> [[Int]] {
    var io = 0

    var mutGraph = graph
    // print("Graph before sorting: \(mutGraph)")

    // ascending order of their degree
    // mutGraph.sorted()


    var vertices = mutGraph.vertexListSortedByDegree()
    // print("Graph after sorting: \(mutGraph)")

    var results = [[Int]](repeating: [], count: mutGraph.maxDegree())

    while !mutGraph.empty {
      print("-- NOT EMPTY: \(mutGraph)")
      io += 1
      let d = mutGraph.minDegree()
      while mutGraph.vertexWith(degree: d) {
        print("---- VERTEX WITH DEGREE \(d): \(mutGraph)")
        // let v = mutGraph.nextVertex
        let v = vertices.removeFirst()
        results[d].append(v)
        mutGraph.delete(vertex: v)
        // mutGraph.sorted()
        vertices = mutGraph.vertexListSortedByDegree()
        print("---- AFTER CHANGES: \(mutGraph)")
      }
    }

    // print("Min Degree: \(mutGraph.minDegree())")
    // print("Max Degree: \(mutGraph.maxDegree())")
    print("- BottomUp -- I/O's: \(io)\n")
    return results
  }
}
