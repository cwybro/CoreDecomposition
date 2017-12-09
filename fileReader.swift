import Foundation

public struct FileResult {
    let points: Int
    let tuples: [(Int, Int)]
}

public class FileReader {
    public class func read(_ fileName: String) -> FileResult? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                var contents = data.components(separatedBy: .newlines).filter { !$0.isEmpty }
                let sizeStr = String(describing: contents.removeFirst())
                guard let size = Int(sizeStr) else {
                    print("Wrong format")
                    return nil
                }
                let result = FileResult(points: size, tuples:contents.parse())
                
                return result
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
}

public extension Array where Element == String {
    public func parse() -> [(Int, Int)] {
        return self.map { str in
            let arr = str.components(separatedBy: .whitespaces)
            return (Int(arr[0])!,Int(arr[1])!)
        }
    }
}

