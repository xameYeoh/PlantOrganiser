
import Foundation
import SwiftData

@Model
final class PlantCareInstruction {
  var wateringFrequency: Frequency
  var showerFrequency: Frequency?
  var sprinklingFrequency: Frequency?

  init(
    wateringFrequency: Frequency,
    showerFrequency: Frequency? = nil,
    sprinklingFrequency: Frequency? = nil
  ) {
    self.wateringFrequency = wateringFrequency
    self.showerFrequency = showerFrequency
    self.sprinklingFrequency = sprinklingFrequency
  }
}
