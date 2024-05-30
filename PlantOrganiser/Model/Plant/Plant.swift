//
//  Plant.swift
//  PlantOrganiser
//
//  Created by Kirill Getmanskii  on 28.05.24.
//

import Foundation
import SwiftData

@Model
final class Plant {
  var name: String
  var careInstruction: PlantCareInstruction?
  var imagePath: String?

  init(name: String, careInstruction: PlantCareInstruction? = nil, imagePath: String? = nil) {
    self.name = name
    self.careInstruction = careInstruction
    self.imagePath = imagePath
  }
}
