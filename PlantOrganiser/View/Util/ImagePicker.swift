import SwiftUI
import PhotosUI

struct ImagePicker: View {
  @Bindable private var plant: Plant

  @State private var item: PhotosPickerItem?

  private let saveImage: (Image?) -> Void

  init(plant: Plant, _ saveImage: @escaping (Image?) -> Void) {
    self.plant = plant
    self.saveImage = saveImage
  }

  var body: some View {
    PhotosPicker(
      selection: $item,
      matching: .images,
      label: {
        Image(systemName: "photo")
      }
    )
    .onChange(of: item) {
      Task {
        let pickedImage = try? await item?.loadTransferable(type: Image.self)
        saveImage(pickedImage)
      }
    }
  }
}

#Preview {
  ImagePicker(plant: SampleData.shared.plant) {_ in }
    .modelContainer(SampleData.shared.modelContainer)
}
