import SwiftUI
import SwiftData

struct PlantList: View {
  @Query private var plants: [Plant]
  var body: some View {
    List {
      ForEach(plants) { plant in
        NavigationLink {
          PlantDetail(plant: plant)
        } label: {
          Text(plant.name)
        }
      }
    }
  }
}

#Preview {
  PlantList()
    .modelContainer(SampleData.shared.modelContainer)
}
