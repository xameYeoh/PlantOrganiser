
import Foundation
import SwiftData

let defaultCareInstruction = PlantCareInstruction(
  wateringFrequency: Frequency(value: 1, unit: .week)
)

@Model
final class PlantCareInstruction {
  var wateringFrequency: Frequency
  var showeringFrequency: Frequency?
  var sprinklingFrequency: Frequency?

  init(
    wateringFrequency: Frequency,
    showerFrequency: Frequency? = nil,
    sprinklingFrequency: Frequency? = nil
  ) {
    self.wateringFrequency = wateringFrequency
    self.showeringFrequency = showerFrequency
    self.sprinklingFrequency = sprinklingFrequency
  }
}
