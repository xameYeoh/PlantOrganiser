import SwiftUI
import Combine
import SwiftData

@Observable
class PlantViewModel {
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

  func delete(_ plant: Plant) {
    /**
     Sometimes the view does not dismiss fast enough when we delete a model.
     When the deletion happens, swift data sets the properties of the observed model (its instance) to nil,
     and view gets NPM crash because it still shows the model with non-nil properties.
     
     I wonder if there is a less cheeky way of handling this, but after researching some forums
     this delay seemed like the easiest way out. One place mentioned that calling modelContext.save()
     should resolve it, but it doesn't.

     Other strange options are marking all observed model's properties nilable
     and safe calling them everywhere or
     making custom getters for all of them and returning default values;
     both options seem even worse to me, as they contradict the intended logic for the models

     > I guess you could use @State fields for everything you have in View,
     and update the model's properties when those get updated; since they are
     not connected directly in this case we shouldn't get a crash. But the downside
     is that it adds way more code to the views than just using the @Bindable model
     > Another approach would be to not have a delete option in a view that observes
     this model at all, and transfer it to a list view for example.
     */
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      self.modelContext.delete(plant)
      self.fetchPlants()
    }
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

  func confirmDelete(plant: Plant) {
    plantToDelete = plant
    showDeleteConfirmation = true
  }
}
