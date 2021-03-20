#!/usr/bin/env swift

import Darwin

struct StderrOutputStream: TextOutputStream {
  mutating func write(_ string: String) { fputs(string, stderr) }
}

var standardError = StderrOutputStream()

print("Some error", to: &standardError)

exit(1)
