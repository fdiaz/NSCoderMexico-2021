import Foundation
import SwiftSyntax

public final class ImportsAnalyzer {
  public static func analyze(fileURL: URL) throws -> [String] {
    let visitor = ImportsVisitor()
    
    let fileSyntax = try SyntaxParser.parse(fileURL)
    
    visitor.walk(fileSyntax)
    
    return visitor.imports
  }
}


private final class ImportsVisitor: SyntaxVisitor {
  var imports: [String] = []
  
  override func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    guard let moduleName = importsName(from: node) else { return .visitChildren }
    imports.append(moduleName)
    return .visitChildren
  }
  
  func importsName(from syntaxNode: ImportDeclSyntax) -> String? {
    for child in syntaxNode.children {
      guard let accessPath = child.as(AccessPathSyntax.self) else { continue }
      
      guard let moduleName = accessPath.first?.name.text else { continue }
      
      return moduleName
    }
    return nil
  }
}
