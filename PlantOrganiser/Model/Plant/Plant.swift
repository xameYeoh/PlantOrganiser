import Foundation
import SwiftData

@Model
final class Plant {
  var name: String
  var careInstruction: PlantCareInstruction
  var image: Data?

  init(
    name: String,
    careInstruction: PlantCareInstruction = defaultCareInstruction,
    image: Data? = nil
  ) {
    self.name = name
    self.careInstruction = careInstruction
    self.image = image
  }
}
