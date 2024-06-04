import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      NavigationStack {
        PlantList()
      }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(SampleData.shared.modelContainer)
}
