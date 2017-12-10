import Foundation

let one = Graph(fileName: "graphs/1_1nbr_ud")
let two = Graph(fileName: "graphs/2_2nbr_ud")
let four = Graph(fileName: "graphs/4_4nbr_ud")
let eight = Graph(fileName: "graphs/8_8nbr_ud")

[("1",one), ("2",two), ("4",four), ("8",eight)].forEach { tuple in
  print("\(tuple.0)")
  print("- bottomUp: \(tuple.1.kCore(type: .bottomUp))\n")
  print("- semiCore: \(tuple.1.kCore(type: .semiCore))\n")
}

// var experiment = Experiment()

// experiment.add(withId: "SemiCore") {
//   graph.kCore(type: .semiCore)
// }

// experiment.add(withId: "BottomUp") {
//   graph.kCore(type: .bottomUp)
// }

// print("Running experiments")
// let result = experiment.run(trials: 1, internalLoops: 1)
// print("Results:")
// print("-- Average: \(result.average)\n")
