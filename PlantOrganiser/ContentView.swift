import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
          NavigationStack {
            PlantDetail(
              plant: SampleData.shared.plant,
              isNew: true
            )
              .navigationBarTitleDisplayMode(.inline)
          }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
