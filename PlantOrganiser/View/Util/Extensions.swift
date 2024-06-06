import SwiftUI

extension Image {
  init?(data: Data?) {
    if let data {
      guard let uiImage = UIImage(data: data) else { return nil }
      self.init(uiImage: uiImage)
    } else {
      return nil
    }
  }

  init(dataOrPlaceholder data: Data?) {
    if let image = Image(data: data) {
      self = image
    } else {
      self.init("plant-placeholder")
    }
  }

  func centerCropped() -> some View {
    GeometryReader { geo in
      self
        .resizable()
        .scaledToFill()
        .frame(width: geo.size.width, height: geo.size.height)
        .clipped()
    }
  }
}

extension View {
  func clickable(onClick: @escaping () -> Void) -> some View {
    self
      .contentShape(Rectangle())
      .onTapGesture(perform: onClick)
  }
  
  /// Attaches default environment values for Previews (e.g. ViewModels, ModelContainer etc.)
  @MainActor func previewEnvironment() -> some View {
    self
      .modelContainer(SampleData.shared.modelContainer)
      .environment(PlantViewModel(modelContext: SampleData.shared.modelContainer.mainContext))
  }
}
