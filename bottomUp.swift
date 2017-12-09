import Foundation

public struct BottomUp {

  public static func run(_ graph: Graph) -> [[Int]] {
    var mutGraph = graph
    // print("Graph: \(mutGraph)")

    // ascending order of their degree
    mutGraph.sorted()
    // print("Graph after sorting: \(mutGraph)")

    while !mutGraph.empty {
      let d = mutGraph.minDegree()


    }

    print("Min Degree: \(mutGraph.minDegree())")
    print("Max Degree: \(mutGraph.maxDegree())")

    return []
  }
}
