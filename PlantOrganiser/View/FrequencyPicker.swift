import SwiftUI

struct FrequencyPicker: View {
  @Binding private var frequency: Frequency
  private let label: String

  init(_ label: String, frequency: Binding<Frequency>) {
    self.label = label
    self._frequency = frequency
  }

  var body: some View {
    HStack {
      Text(label)
        .frame(maxWidth: .infinity, alignment: .leading)

      Picker("", selection: $frequency.value) {
        ForEach(1...10, id: \.self) { value in
          Text("\(value)")
        }
      }
      Picker("", selection: $frequency.unit) {
        ForEach(Frequency.Unit.allCases) { unit in
          Text(unit.rawValue.capitalized)
        }
      }
    }
  }
}
