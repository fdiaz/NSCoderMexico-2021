import Nimble
import Quick
import Foundation

@testable import SwiftImportsCore

final class ImportsAnalyzerSpec: QuickSpec {
  override func spec() {
    var content = ""
    
    beforeEach {
      content = ""
    }
    
    describe("analyze") {
      context("when there is no import statement") {
        let content = """
                      public final class Some {
                      }
                      """
        
        it("returns an empty array") {
          let fileURL = try Temporary.makeFile(content: content)
          let output = try ImportsAnalyzer.analyze(fileURL: fileURL)
          expect(output).to(beEmpty())
        }
      }
      
      context("with a simple import statements") {
        beforeEach {
          content = """
                        import SomeModule

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

      context("with multiple import statements") {
        beforeEach {
          content = """
                        import SomeModule
                        import AnotherModule

                        public final class Some {
                        }
                        """
        }
        
        it("returns the appropriate module name") {
          let fileURL = try Temporary.makeFile(content: content)
          let output = try ImportsAnalyzer.analyze(fileURL: fileURL)
          expect(output) == ["SomeModule", "AnotherModule"]
        }
      }
      
    }
    
  }
}
