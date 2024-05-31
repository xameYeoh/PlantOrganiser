import Foundation
import SwiftData

@Model
final class Plant {
  var name: String
  var careInstruction: PlantCareInstruction
  var imagePath: String?

  init(
    name: String,
    careInstruction: PlantCareInstruction = defaultCareInstruction,
    imagePath: String? = nil
  ) {
    self.name = name
    self.careInstruction = careInstruction
    self.imagePath = imagePath
  }
}
