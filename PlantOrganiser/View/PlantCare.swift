import SwiftUI

struct PlantCare: View {
  @Binding var careInstruction: PlantCareInstruction

  @State private var showeringNeeded = false
  @State private var showeringFrequency = Frequency(value: 1, unit: .week)
  @State private var sprinklingNeeded = false
  @State private var sprinklingFrequency = Frequency(value: 1, unit: .day)

  init(careInstruction: Binding<PlantCareInstruction>) {
    self._careInstruction = careInstruction
  }

  var body: some View {
    Section("Main care") {
      FrequencyPicker("Water every", frequency: $careInstruction.wateringFrequency)
    }
    Section("Optional care") {
      Toggle(isOn: $showeringNeeded, label: { Text("Requires showering") })
        .onChange(of: showeringNeeded) {
          careInstruction.showeringFrequency = showeringNeeded ? showeringFrequency : nil
        }
      if showeringNeeded {
        FrequencyPicker("Every", frequency: $showeringFrequency)
      }

      Toggle(isOn: $sprinklingNeeded, label: { Text("Requires sprinkling") })
        .onChange(of: sprinklingNeeded) {
          careInstruction.sprinklingFrequency = sprinklingNeeded ? sprinklingFrequency : nil
        }
      if sprinklingNeeded {
        FrequencyPicker("Every", frequency: $sprinklingFrequency)
      }
    }
  }
}

#Preview {
  Form {
    PlantCare(careInstruction: .constant(defaultCareInstruction))
      .modelContainer(SampleData.shared.modelContainer)
  }
}
