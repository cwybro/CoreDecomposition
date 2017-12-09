import Foundation

let graph = Graph(fileName: "graphs/graph_small")

print("bottomUp: \(graph.kCore(type: .bottomUp))")
print("semiCore: \(graph.kCore(type: .semiCore))")

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
