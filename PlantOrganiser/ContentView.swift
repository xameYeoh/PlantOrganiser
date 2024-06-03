import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      NavigationStack {
        PlantList()
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
    .modelContainer(SampleData.shared.modelContainer)
}
