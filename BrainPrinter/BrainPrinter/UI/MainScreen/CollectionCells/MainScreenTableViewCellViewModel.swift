//
//  MainScreenTableViewCellViewModel.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 30.08.22.
//

import Foundation
import UIKit

struct MainScreenTableViewCellViewModel: MainScreenColletionResourceProtocol {
    var image: UIImage
    var title: String
    var subtitle: String
    var resourceType: ResourceType
}
