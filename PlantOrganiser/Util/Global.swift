import Foundation
import SwiftData

func getDocumentsDirectory() -> URL {
  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

extension ModelContext {
  var sqliteCommand: String {
    if let url = container.configurations.first?.url.path(percentEncoded: false) {
      "sqlite3 \"\(url)\""
    } else {
      "No SQLite database found."
    }
  }
}
