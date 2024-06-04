import SwiftUI

struct Card: View {
  @Bindable private var plant: Plant
  @State private var image: Image?

  init(plant: Plant) {
    self.plant = plant
  }

  var body: some View {
    VStack(alignment: .leading) {
      Group {
        if let image {
          image
            .centerCropped()
        } else {
          ImagePicker(plant: plant, { pickedImage in
            image = pickedImage
          })
        }
      }
      .frame(maxWidth: .infinity, maxHeight: 200)

      text
    }
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 25.0))
    .shadow(radius: 8)
  }


  var text: some View {
    VStack {
      Text(plant.name)
        .padding(.top, 10)
        .padding(.horizontal, 30)
        .padding(.bottom, 25)
        .font(.title)
    }
  }
}

#Preview {
  Card(plant: SampleData.shared.plant)
    .modelContainer(SampleData.shared.modelContainer)
}
