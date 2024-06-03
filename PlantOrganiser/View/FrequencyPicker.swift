import SwiftUI

struct FrequencyPicker: View {
  @Bindable private var frequency: Frequency
  private let label: String

  init(_ label: String, frequency: Frequency) {
    self.label = label
    self.frequency = frequency
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

#Preview {
  FrequencyPicker("Frequency", frequency: SampleData.shared.frequency)
}
