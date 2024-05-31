import SwiftUI

struct PlantDetail: View {
  @Bindable private var plant: Plant

  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext

  @State private var wateringFrequency: Frequency = Frequency(value: 1, unit: .week)


  private let isNew: Bool

  init(plant: Plant, isNew: Bool = false) {
    self.isNew = isNew
    self.plant = plant
  }

  var body: some View {
    VStack {
      Form {
        TextField("Plant name", text: $plant.name)
        
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
    PlantDetail(
      plant: Plant(
        name: "",
        careInstruction: defaultCareInstruction
      ),
      isNew: true
    )
      .navigationBarTitleDisplayMode(.inline)
  }
  .modelContainer(SampleData.shared.modelContainer)
}
