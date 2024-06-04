import SwiftUI
import SwiftData

struct PlantList: View {
  @Query(sort: \Plant.name) private var plants: [Plant]

  @Environment(\.modelContext) private var modelContext

  @State private var newPlant: Plant?

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
