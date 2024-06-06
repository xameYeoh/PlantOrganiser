import SwiftUI
import PhotosUI

struct ImagePicker<Content: View>: View {
  @Bindable private var plant: Plant

  @State private var item: PhotosPickerItem?

  private let onImageDataReceived: (Data?) -> Void
  private let label: Content

  init(
    plant: Plant,
    label: Content,
    _ saveImage: @escaping (Data?) -> Void
  ) {
    self.plant = plant
    self.onImageDataReceived = saveImage
    self.label = label
  }

  var body: some View {
    PhotosPicker(
      selection: $item,
      matching: .images,
      label: {
        label
      }
    )
    .onChange(of: item) {
      Task {
        onImageDataReceived(try? await item?.loadTransferable(type: Data.self))
      }
    }
  }
}

#Preview {
  ImagePicker(plant: SampleData.shared.plant, label: Text("Pick image")) {_ in }
    .modelContainer(SampleData.shared.modelContainer)
}
