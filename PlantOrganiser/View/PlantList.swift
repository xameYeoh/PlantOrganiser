import SwiftUI
import SwiftData

struct PlantList: View {
  @Environment(PlantListViewModel.self) var viewModel

  @State private var isConfirmationDialogShown: Bool = false
  @State private var isSheetShown = false

  var body: some View {
    Group {
      if !viewModel.plants.isEmpty{
        ScrollView {
          VStack(spacing: 30) {
            ForEach(viewModel.plants) { plant in
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
        Button(action: {
          viewModel.addPlant()
          isSheetShown = true
        }) {
          Label("Add plant", systemImage: "plus")
        }
      }
    }
    .sheet(isPresented: $isSheetShown) {
      if let newPlant = viewModel.newPlant {
        NavigationStack {
          PlantDetail(plant: newPlant, isNew: true)
        }
        .interactiveDismissDisabled()
      }
    }
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
