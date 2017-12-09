import Foundation

let graph = Graph(fileName: "graphs/path_1000")

var experiment = Experiment()

experiment.add(withId: "SemiCore") {
  graph.kCore(type: .semiCore)
}

print("Running experiments")
let result = experiment.run(trials: 1, internalLoops: 1)
print("Results:")
print("-- Average: \(result.average)\n")
