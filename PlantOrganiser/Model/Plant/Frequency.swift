import Foundation
import SwiftData

@Model
final class Frequency {
  enum Unit : String, Identifiable, Hashable, CaseIterable, Codable {
    var id: Self { self }

    case hour
    case day
    case week
  }

  var value: Int
  var unit: Unit

  init(value: Int, unit: Unit) {
    self.value = value
    self.unit = unit
  }
}

extension Date {
  func plus(frequency: Frequency) -> Date {
    let dateComponents = switch frequency.unit {
    case .hour:
      DateComponents(hour: frequency.value)
    case .day:
      DateComponents(day: frequency.value)
    case .week:
      DateComponents(weekOfYear: frequency.value)
    }

    return Calendar.current.date(byAdding: dateComponents, to: self)!
  }
}
