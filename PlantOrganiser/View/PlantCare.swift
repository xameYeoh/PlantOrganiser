import SwiftUI

struct PlantCare: View {
  @Bindable var careInstruction: PlantCareInstruction

  @State private var showeringNeeded: Bool
  @State private var showeringFrequency: Frequency
  @State private var sprinklingNeeded: Bool
  @State private var sprinklingFrequency: Frequency

  init(careInstruction: PlantCareInstruction) {
    self.careInstruction = careInstruction
    self.showeringNeeded = careInstruction.showeringFrequency != nil
    self.showeringFrequency = careInstruction.showeringFrequency
    ?? Frequency(value: 1, unit: .week)
    self.sprinklingNeeded = careInstruction.sprinklingFrequency != nil
    self.sprinklingFrequency = careInstruction.sprinklingFrequency
    ?? Frequency(value: 4, unit: .hour)
  }

  var body: some View {
    Section("Main care") {
      FrequencyPicker("Water every", frequency: careInstruction.wateringFrequency)
    }
    Section("Optional care") {
      Toggle(isOn: $showeringNeeded, label: { Text("Requires showering") })
        .onChange(of: showeringNeeded) {
          careInstruction.showeringFrequency = showeringNeeded ? showeringFrequency : nil
        }
      if showeringNeeded {
        FrequencyPicker("Every", frequency: showeringFrequency)
      }

      Toggle(isOn: $sprinklingNeeded, label: { Text("Requires sprinkling") })
        .onChange(of: sprinklingNeeded) {
          careInstruction.sprinklingFrequency = sprinklingNeeded ? sprinklingFrequency : nil
        }
      if sprinklingNeeded {
        FrequencyPicker("Every", frequency: sprinklingFrequency)
      }
    }
  }
}

#Preview {
  Form {
    PlantCare(careInstruction: SampleData.shared.plant.careInstruction)
      .modelContainer(SampleData.shared.modelContainer)
  }
}
