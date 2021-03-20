import ArgumentParser
import Foundation
import SwiftImportsCore

final class ImportsCommand: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "imports",
    abstract: "Finds all the declared imports in a Swift file"
  )
  
  @Argument(help: "The path to the file or directory to inspect")
  var path: String
  
  func run() throws {
    let fileURL = URL(fileURLWithPath: path)
    
    let outputArray = try FileManager.default.swiftFiles(at: fileURL)
      .reduce(Set<String>()) { result, url in
        let output = try ImportsAnalyzer.analyze(fileURL: url)
        return result.union(output)
      }
    
    let output = outputArray.joined(separator: "\n")
    print(output)
  }
}

ImportsCommand.main()
