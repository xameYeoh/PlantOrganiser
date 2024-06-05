import SwiftUI
import SwiftData

struct PlantDetail: View {
  @Bindable private var plant: Plant

  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext

  @State private var showDeleteConfirmation = false

  private let isNew: Bool

  init(plant: Plant, isNew: Bool = false) {
    self.isNew = isNew
    self.plant = plant
  }

  var body: some View {
    VStack {
      let image = Image(data: plant.image) ?? Image("plant-placeholder")
      image
        .resizable()
        .centerCropped()
        .frame(height: 170)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
      Form {
        Section("Name") {
          TextField("Plant name", text: $plant.name)
            .onChange(of: plant.name) { oldValue, newValue in
              print(modelContext.sqliteCommand)
            }
        }
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
            dismiss()
            modelContext.delete(plant)
          }
        }
      } else {
        ToolbarItem(placement: .destructiveAction) {
          Button(action: {
            showDeleteConfirmation = true
          }, label: {
            Text("Delete")
              .foregroundStyle(Color.red)
          })
        }
      }
    }
    .alert(isPresented: $showDeleteConfirmation, content: {
      Alert(
        title: Text("Delete Plant"),
        message: Text("Are you sure you want to delete this plant?"),
        primaryButton: .destructive(Text("Delete")) {
          dismiss() // Dismiss the view first
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            modelContext.delete(plant) // Delete the plant after a short delay
          }
        },
        secondaryButton: .cancel())
    })

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
