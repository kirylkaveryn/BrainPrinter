//
//  MainScreenTableViewCellViewModel.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 30.08.22.
//

import Foundation
import UIKit

struct MainScreenTableViewCellViewModel: MainScreenItemContentProtocol {
    var image: UIImage
    var title: String
    var subtitle: String
    var sourceType: SourceType
}
