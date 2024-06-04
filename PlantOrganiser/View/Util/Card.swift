import SwiftUI

struct Card: View {
  @Bindable private var plant: Plant
  @State private var image: Image = Image("plant-placeholder")

  init(plant: Plant) {
    self.plant = plant
  }

  var body: some View {
    VStack(alignment: .leading) {
      image
        .centerCropped()
        .frame(maxWidth: .infinity, maxHeight: 200)

      HStack(alignment: .center) {
        VStack(alignment: .leading) {
          Text(plant.name)
            .font(.title)
            .foregroundStyle(Color.black)

          Text("Shower every: \(plant.careInstruction.wateringFrequency.value) \(plant.careInstruction.wateringFrequency.unit.rawValue)")

          if let showeringFrequency = plant.careInstruction.showeringFrequency {
            Text("Shower every: \(showeringFrequency.value) \(showeringFrequency.unit.rawValue)")
          }

          if let sprinklingFrequency = plant.careInstruction.sprinklingFrequency {
            Text("Shower every: \(sprinklingFrequency.value) \(sprinklingFrequency.unit.rawValue)")
          }
        }
        Spacer()
        Image(systemName: "chevron.forward")
      }
      .foregroundStyle(Color.gray)
      .padding(.horizontal, 30)
      .padding(.top, 10)
      .padding(.bottom, 20)
    }
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 25.0))
    .shadow(radius: 8)
  }
}

#Preview {
  Card(plant: SampleData.shared.plant)
    .modelContainer(SampleData.shared.modelContainer)
}
