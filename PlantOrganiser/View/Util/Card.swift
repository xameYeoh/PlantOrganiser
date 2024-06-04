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
        Text(plant.name)
          .font(.title)
        Spacer()
        ImagePicker(plant: plant, { pickedImage in
          image = pickedImage ?? Image("plant-placeholder")
        })
      }
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
