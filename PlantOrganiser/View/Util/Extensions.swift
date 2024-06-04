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
}
