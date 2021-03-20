import Nimble
import Quick
import Foundation

@testable import SwiftImportsCore

final class ImportsAnalyzerComplexSpec: QuickSpec {
  override func spec() {
    var content = ""
    
    beforeEach {
      content = ""
    }
    
    describe("analyze") {
      
      context("with an import statement with an attribute") {
        beforeEach {
          content = """
                        @_exported import SomeModule

                        public final class Some {
                        }
                        """
        }
        
        it("returns the appropriate module name") {
          let fileURL = try Temporary.makeFile(content: content)
          let output = try ImportsAnalyzer.analyze(fileURL: fileURL)
          expect(output.first) == "SomeModule"
        }
      }
      
      context("with an import statement with a submodule") {
        beforeEach {
          content = """
                        import SomeModule.Submodule
                        import AnotherModule

                        public final class Some {
                        }
                        """
        }

        it("returns the appropriate module names") {
          let fileURL = try Temporary.makeFile(content: content)
          let output = try ImportsAnalyzer.analyze(fileURL: fileURL)
          expect(output) == ["SomeModule", "AnotherModule"]
        }
      }
      
      context("with an import statement with a kind and a submodule") {
        beforeEach {
          content = """
                        import struct SomeModule.Submodule

                        public final class Some {
                        }
                        """
        }
        
        it("returns the appropriate module names") {
          let fileURL = try Temporary.makeFile(content: content)
          let output = try ImportsAnalyzer.analyze(fileURL: fileURL)
          expect(output) == ["SomeModule"]
        }
      }
      
    }
    
  }
}
