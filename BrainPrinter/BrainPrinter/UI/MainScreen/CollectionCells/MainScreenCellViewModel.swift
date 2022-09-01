//
//  MainScreenCellViewModel.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 30.08.22.
//

import Foundation
import UIKit

protocol MainScreenItemContentProtocol {
    var image: UIImage { get }
    var title: String { get }
    var subtitle: String { get }
}

struct MainScreenCellViewModel: MainScreenItemContentProtocol {
    var image: UIImage
    var title: String
    var subtitle: String
    var cellDidPress: (() -> ())?
}
