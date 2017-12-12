import Foundation

let fullSuite = (1...12).map { "graphs/udSuite/\(pow(2,$0))_\(pow(2,$0))nbr_ud" }

let pathSuite = (1...13).map { "graphs/pathSuite/path_\(pow(2,$0))" }

let snapSuite = ["graphs/snapSuite/youtube"]

let vTest = "graphs/verify_small"

let smallTest = "graphs/2_2nbr_ud"
let largeTest = "graphs/amazon"

func fullTest(_ graphs: [String]) {
  print("---- Running full test suite ----")

  graphs.forEach { name in
    print("--------------------------------")
    print("EXPERIMENT FOR: \(name)")

    let graph = Graph(fileName: name)
    var experiment = Experiment()

    experiment.add(withId: "SemiCore") {
      graph.kCore(type: .semiCore)
    }

    experiment.add(withId: "IMCore") {
      graph.kCore(type: .imCore)
    }

    let result = experiment.run(trials: 3, internalLoops: 1)
    print("Results:")
    print("-- Average: \(result.average)\n")
    print(result.compare(to: "SemiCore"))
    print("--------------------------------\n")
  }
}

func verifyTest(_ graphName: String) {
  print("---- Running verification test ----")

  let graph = Graph(fileName: graphName)

  print("VERIFY: SemiCore")
  print("-- Results: \(graph.kCore(type: .semiCore))")
  print("--------------------------------\n")
  print("VERIFY: IMCore")
  print("-- Results: \(graph.kCore(type: .imCore))")
}

enum TestType {
case small, large
}

func specificTest(_ type: TestType) {
  if type == .large {
    print("---- Running large graph test ----")
  } else {
    print("---- Running small graph test ----")
  }

  let file = type == .large ? largeTest : smallTest
  let graph = Graph(fileName: file)

  var experiment = Experiment()

  experiment.add(withId: "SemiCore") {
    graph.kCore(type: .semiCore)
  }

  experiment.add(withId: "IMCore") {
    graph.kCore(type: .imCore)
  }

  let result = experiment.run(trials: 1, internalLoops: 1)
  print("Results:")
  print("-- Average: \(result.average)\n")
  print(result.compare(to: "SemiCore"))
  print("--------------------------------\n")
}

func snapTest(_ graphs: [String]) {
  print("---- Running SNAP test suite ----")

  graphs.forEach { name in
    print("--------------------------------")
    print("EXPERIMENT FOR: \(name)")

    let graph = Graph(fileName: name)
    var experiment = Experiment()

    experiment.add(withId: "SemiCore") {
      graph.kCore(type: .semiCore)
    }

    experiment.add(withId: "IMCore") {
      graph.kCore(type: .imCore)
    }

    let result = experiment.run(trials: 1, internalLoops: 1)
    print("Results:")
    print("-- Average: \(result.average)\n")
    print(result.compare(to: "SemiCore"))
    print("--------------------------------\n")
  }
}

func report_memory() -> mach_vm_size_t {
    var info = mach_task_basic_info()
    var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4

    let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
        $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
            task_info(mach_task_self_,
                      task_flavor_t(MACH_TASK_BASIC_INFO),
                      $0,
                      &count)
        }
    }

    if kerr == KERN_SUCCESS {
        return info.resident_size
    }
    else {
        print("Error with task_info(): " +
            (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error"))
        return 0
    }
}

func singleTest(_ graphs: [String]) {
  print("---- Running path test suite ----")

  graphs.forEach { name in
    print("--------------------------------")
    print("EXPERIMENT FOR: \(name)")

    let graph = Graph(fileName: name)
    var experiment = Experiment()

    experiment.add(withId: "SemiCore") {
      graph.kCore(type: .semiCore)
    }

    experiment.add(withId: "IMCore") {
      graph.kCore(type: .imCore)
    }

    let result = experiment.run(trials: 3, internalLoops: 1)
    print("Results:")
    print("-- Average: \(result.average)\n")
    print(result.compare(to: "SemiCore"))
    print("--------------------------------\n")
  }
}

let args = CommandLine.arguments
if args.count == 1 {
  fullTest(fullSuite)
} else if args.count == 2 && args[1] == "verify" {
  verifyTest(vTest)
} else if args.count == 2 && (args[1] == "large" || args[1] == "small") {
  let type: TestType = args[1] == "large" ? .large : .small
  specificTest(type)
} else if args.count == 2 && args[1] == "snap" {
  snapTest(snapSuite)
} else if args.count == 2 && args[1] == "path" {
  singleTest(pathSuite)
}
