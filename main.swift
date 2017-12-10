import Foundation

let fullTest = ["graphs/2_2nbr_ud",
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

let vTest = "graphs/verify"

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
  print("---- Running vertification test ----")

  let graph = Graph(fileName: graphName)

  print("VERIFY: SemiCore")
  print("-- Results: \(graph.kCore(type: .semiCore))")
  print("--------------------------------\n")
  print("VERIFY: IMCore")
  print("-- Results: \(graph.kCore(type: .imCore))")
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

let args = CommandLine.arguments
if args.count == 1 {
  fullTest(fullTest)
} else if args.count == 2 && args[1] == "verify" {
  verifyTest(vTest)
}
