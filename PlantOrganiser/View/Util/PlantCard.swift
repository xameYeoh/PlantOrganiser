import SwiftUI

struct PlantCard: View {
  @Bindable private var plant: Plant
  @State private var image: Image

  init(plant: Plant) {
    self.plant = plant
    self.image = Image(data: plant.image) ?? Image("plant-placeholder")
  }

  var body: some View {
    VStack(alignment: .leading) {
      image
        .centerCropped()

      HStack(alignment: .center) {
        VStack(alignment: .leading) {
          Text(plant.name)
            .font(.title)
            .foregroundStyle(Color.black)
            .padding(.bottom, 4)

          Text("Water every: \(plant.careInstruction.wateringFrequency.value) \(plant.careInstruction.wateringFrequency.unit.rawValue)")

          if let showeringFrequency = plant.careInstruction.showeringFrequency {
            Text("Shower every: \(showeringFrequency.value) \(showeringFrequency.unit.rawValue)")
          }

          if let sprinklingFrequency = plant.careInstruction.sprinklingFrequency {
            Text("Sprinkle every: \(sprinklingFrequency.value) \(sprinklingFrequency.unit.rawValue)")
          }
          Spacer()
        }
        Spacer()
        Image(systemName: "chevron.forward")
      }
      .foregroundStyle(Color.gray)
      .padding(.horizontal, 20)
      .padding(.top, 10)
      .padding(.bottom, 20)
      .frame(height: 140)
    }
    .frame(height: 320)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 25.0))
    .shadow(radius: 8)
  }
}

#Preview {
  PlantCard(plant: SampleData.shared.plant)
    .modelContainer(SampleData.shared.modelContainer)
}
