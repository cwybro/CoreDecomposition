import Foundation

let graphs = ["graphs/2_2nbr_ud",
              "graphs/4_4nbr_ud",
              "graphs/8_8nbr_ud",
              "graphs/16_16nbr_ud",
              "graphs/32_32nbr_ud",
              "graphs/64_64nbr_ud",
              "graphs/128_128nbr_ud",
              "graphs/256_256nbr_ud",
              "graphs/512_512nbr_ud",
              "graphs/1024_1024nbr_ud",
              "graphs/2048_2048nbr_ud",
              "graphs/4096_4096nbr_ud",
              "graphs/8192_8192nbr_ud"]

graphs.forEach { name in
  print("--------------------------------")
  print("EXPERIMENT FOR: \(name)")

  let graph = Graph(fileName: name)
  var experiment = Experiment()

  experiment.add(withId: "SemiCore") {
    graph.kCore(type: .semiCore)
  }

  experiment.add(withId: "BottomUp") {
    graph.kCore(type: .bottomUp)
  }

  let result = experiment.run(trials: 3, internalLoops: 1)
  print("Results:")
  print("-- Average: \(result.average)\n")
  print(result.compare(to: "SemiCore"))
  print("--------------------------------\n")
}
