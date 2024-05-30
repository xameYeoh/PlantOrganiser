import SwiftUI

struct PlantDetail: View {
  @Bindable private var plant: Plant

  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext

  @State private var wateringFrequency: Frequency = Frequency(value: 1, unit: .week)

  @State private var showeringNeeded = false
  @State private var showeringFrequency = Frequency(value: 1, unit: .week)

  @State private var sprinklingNeeded = false
  @State private var sprinklingFrequency = Frequency(value: 1, unit: .day)

  private let isNew: Bool

  init(plant: Plant, isNew: Bool = false) {
    self.isNew = isNew
    self.plant = plant
  }

  var body: some View {
    VStack {
      Form {
        TextField("Plant name", text: $plant.name)
        FrequencyPicker("Water every", frequency: $wateringFrequency)
        Section {
          Toggle(isOn: $showeringNeeded, label: { Text("Needs showering") })
          if showeringNeeded {
            FrequencyPicker("Every", frequency: $showeringFrequency)
          }
        }
        Section {
          Toggle(isOn: $sprinklingNeeded, label: { Text("Needs sprinkling") })
          if sprinklingNeeded {
            FrequencyPicker("Every", frequency: $sprinklingFrequency)
          }
        }
      }
    }
    .navigationTitle(isNew ? "New Plant" : "Plant")
    .toolbar {
      if isNew {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            dismiss()
          }
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            modelContext.delete(plant)
            dismiss()
          }
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    PlantDetail(plant: SampleData.shared.plant)
  }
  .modelContainer(SampleData.shared.modelContainer)
}

#Preview("New") {
  NavigationStack {
    PlantDetail(plant: Plant(name: ""), isNew: true)
      .navigationBarTitleDisplayMode(.inline)
  }
  .modelContainer(SampleData.shared.modelContainer)
}
