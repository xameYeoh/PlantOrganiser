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
        Text("Change photo")
      }
    )
    .onChange(of: item) {
      Task {
        plant.image = try? await item?.loadTransferable(type: Data.self)
      }
    }
  }
}
//func saveImageToDocumentsDirectory(image: UIImage) -> String? {
//  guard let data = image.jpegData(compressionQuality: 1) else { return nil }
//  let filename = UUID().uuidString + ".jpg"
//  let url = getDocumentsDirectory().appendingPathComponent(filename)
//
//  do {
//    try data.write(to: url)
//    return filename
//  } catch {
//    print("Failed to save image: \(error)")
//    return nil
//  }
//}

//func loadImageFromDocumentsDirectory(filename: String) -> UIImage? {
//  let url = getDocumentsDirectory().appendingPathComponent(filename)
//  return UIImage(contentsOfFile: url.path)
//}

#Preview {
  ImagePicker(plant: SampleData.shared.plant) {_ in }
    .modelContainer(SampleData.shared.modelContainer)
}
