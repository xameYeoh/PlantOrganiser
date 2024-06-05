import SwiftUI
import SwiftData

struct PlantList: View {
  @Query(sort: \Plant.name) private var plants: [Plant]

  @Environment(\.modelContext) private var modelContext

  @State private var newPlant: Plant?
  @State private var plantToDelete: Plant?

  @State private var isConfirmationDialogShown: Bool = false

  var body: some View {
    Group {
      if !plants.isEmpty{
        ScrollView {
          VStack(spacing: 30) {
            ForEach(plants) { plant in
              NavigationLink {
                PlantDetail(plant: plant)
              } label: {
                PlantCard(plant: plant)
                  .gesture(LongPressGesture(minimumDuration: 0.3).onEnded({ _ in
                    plantToDelete = plant
                    isConfirmationDialogShown = true
                  }))
              }
            }
          }
          .padding()
        }
      } else {
        ContentUnavailableView {
          Label("No plants", systemImage: "leaf")
        }
      }
    }
    .navigationTitle("Plants")
    .confirmationDialog(
      "Select option",
      isPresented: $isConfirmationDialogShown,
      actions: {
        Button("Delete", role: .destructive) {
          print("Deleting plant: \(String(describing: plantToDelete))")
          if let plantToDelete {
            modelContext.delete(plantToDelete)
          }
        }
        Button("Cancel", role: .cancel) {
          plantToDelete = nil
        }
    })
    .toolbar {
      ToolbarItem {
        Button(action: addPlant) {
          Label("Add plant", systemImage: "plus")
        }
      }
    }
    .sheet(item: $newPlant) { newPlant in
      NavigationStack {
        PlantDetail(plant: newPlant, isNew: true)
      }
      .interactiveDismissDisabled()
    }
  }

  private func addPlant() {
    let newPlant = Plant(name: "")
    modelContext.insert(newPlant)
    self.newPlant = newPlant
  }
}

#Preview {
  NavigationStack {
    PlantList()
  }
  .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty") {
  NavigationStack {
    PlantList()
  }
}
