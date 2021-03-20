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
    // TODO: Find imports and send the information to standard output
  }
}

ImportsCommand.main()
