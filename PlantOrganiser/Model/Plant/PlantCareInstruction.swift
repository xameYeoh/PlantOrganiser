
import Foundation
import SwiftData

let defaultCareInstruction = PlantCareInstruction(
  wateringFrequency: Frequency(value: 1, unit: .week)
)

@Model
final class PlantCareInstruction {
  @Relationship(deleteRule: .cascade) var wateringFrequency: Frequency
  @Relationship(deleteRule: .cascade) var showeringFrequency: Frequency?
  @Relationship(deleteRule: .cascade) var sprinklingFrequency: Frequency?

  init(
    wateringFrequency: Frequency,
    showeringFrequency: Frequency? = nil,
    sprinklingFrequency: Frequency? = nil
  ) {
    self.wateringFrequency = wateringFrequency
    self.showeringFrequency = showeringFrequency
    self.sprinklingFrequency = sprinklingFrequency
  }
}
