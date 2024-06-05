import SwiftUI
import SwiftData

@main
struct PlantOrganiserApp: App {
  @State private var plantListViewModel: PlantListViewModel

  init() {
    plantListViewModel = PlantListViewModel(modelContext: sharedModelContainer.mainContext)
  }

  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Plant.self,
      PlantCareInstruction.self,
      Frequency.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()


  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(sharedModelContainer)
    .environment(plantListViewModel)
  }
}
