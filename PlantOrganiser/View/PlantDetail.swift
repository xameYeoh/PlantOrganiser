import SwiftUI
import SwiftData

struct PlantDetail: View {
  @Bindable private var plant: Plant

  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext

  @State private var plantCareInstruction: PlantCareInstruction = defaultCareInstruction

  private let isNew: Bool

  init(plant: Plant, isNew: Bool = false) {
    self.isNew = isNew
    self.plant = plant
  }

  var body: some View {
    VStack {
      Form {
        TextField("Plant name", text: $plant.name)
        PlantCare(careInstruction: plant.careInstruction)
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
      plant: SampleData.shared.plant,
      isNew: true
    )
      .navigationBarTitleDisplayMode(.inline)
  }
  .modelContainer(SampleData.shared.modelContainer)
}
