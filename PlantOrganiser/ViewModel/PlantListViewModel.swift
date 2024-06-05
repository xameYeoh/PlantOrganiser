import SwiftUI
import Combine
import SwiftData

@Observable
class PlantListViewModel {
  var plants: [Plant] = []
  private (set) var newPlant: Plant?
  var plantToDelete: Plant?
  var showDeleteConfirmation = false

  private var modelContext: ModelContext

  init(modelContext: ModelContext) {
    self.modelContext = modelContext
    fetchPlants()
  }

  private func fetchPlants() {
    let request = FetchDescriptor<Plant>(sortBy: [SortDescriptor(\.name)])
    if let results = try? modelContext.fetch(request) {
      self.plants = results
    }
  }

  func clearNewPlant() {
    newPlant = nil
  }

  func addPlant() {
    let newPlant = Plant(name: "")
    modelContext.insert(newPlant)
    self.newPlant = newPlant
    fetchPlants()
  }

  func cancelAddingPlant() {
    if let newPlant = newPlant {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.modelContext.delete(newPlant)
        self.newPlant = nil
        self.fetchPlants()
      }
    }
  }

  func delete(_ plant: Plant) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      self.modelContext.delete(plant)
      self.fetchPlants()
    }
  }

  func confirmDelete(plant: Plant) {
    plantToDelete = plant
    showDeleteConfirmation = true
  }
}
