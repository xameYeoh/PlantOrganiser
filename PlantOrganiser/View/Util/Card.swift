import SwiftUI

struct Card: View {
  @Bindable private var plant: Plant
  @State private var image: Image?

  init(plant: Plant) {
    self.plant = plant
  }

  var body: some View {
    VStack {
      Group {
        if let image {
          image
            .resizable()
            .scaledToFill()
        } else {
          ImagePicker(plant: plant, { pickedImage in
            image = pickedImage
          })
        }
      }
      .frame(width: 300, height: 300)


      text
        .padding(.vertical, 24)
    }
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 25.0))
    .shadow(radius: 8)
    .frame(minWidth: 300, minHeight: 300)
  }

  var text: some View {
    VStack {
      Text(plant.name)
    }
  }
}

#Preview {
  Card(plant: SampleData.shared.plant)
    .modelContainer(SampleData.shared.modelContainer)
}
