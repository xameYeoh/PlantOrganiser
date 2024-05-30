import Foundation
import SwiftData

@MainActor
struct SampleData {
  static let shared = SampleData()
  let plant = Plant(name: "Ficus")
  let plants = [
    Plant(name: "Ficus"),
    Plant(name: "Monsterra"),
    Plant(name: "Palm"),
  ]
  let modelContainer: ModelContainer

  var context: ModelContext {
    modelContainer.mainContext
  }

  private init() {
    let schema = Schema([
      Plant.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

    do {
      modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])

      insertSampleData()
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }

  private func insertSampleData() {
    for plant in plants {
      context.insert(plant)
    }

    do {
      try context.save()
    } catch {
      print("Sample data could not be saved")
    }
  }
}
