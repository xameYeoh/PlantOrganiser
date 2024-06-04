import Foundation
import SwiftData

@Model
final class Plant {
  var name: String
  @Relationship(deleteRule: .cascade) var careInstruction: PlantCareInstruction
  var image: Data?

  init(
    name: String,
    careInstruction: PlantCareInstruction = PlantCareInstruction(
      wateringFrequency: Frequency(value: 1, unit: .week)
    ),
    image: Data? = nil
  ) {
    self.name = name
    self.careInstruction = careInstruction
    self.image = image
  }
}
