import Foundation

func getDocumentsDirectory() -> URL {
  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}
