import Foundation
import SwiftData

@MainActor
struct SampleData {
  static let shared = SampleData()

  let plant: Plant
  let plants: Array<Plant>
  let modelContainer: ModelContainer
  let frequency: Frequency

  var context: ModelContext {
    modelContainer.mainContext
  }

  private init() {
    plant = Plant(
      name: "Ficus",
      careInstruction: PlantCareInstruction(
        wateringFrequency: Frequency(value: 1, unit: .day),
        showeringFrequency: Frequency(value: 1, unit: .day),
        sprinklingFrequency: Frequency(value: 1, unit: .day)
      )
    )
    plants = [
      plant,
      Plant(name: "Monsterra"),
      Plant(name: "Palm"),
    ]
    frequency = Frequency(value: 1, unit: .day)
    let schema = Schema([
      Plant.self,
      PlantCareInstruction.self,
      Frequency.self,
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
