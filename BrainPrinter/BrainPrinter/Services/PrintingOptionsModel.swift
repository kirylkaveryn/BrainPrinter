//
//  PrintingOptionsModel.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation
import UIKit

enum ImageOrientation: Int, CaseIterable, Hashable, Any {
    case portrait, landscape
}

extension ImageOrientation {
    var image: UIImage {
        switch self {
        case .portrait:
            return UIImage(systemName: "list.bullet.rectangle.portrait")!
        case .landscape:
            return UIImage(systemName: "list.bullet.rectangle")!
        }
    }
}

enum ImagesPerPageCount: Int, CaseIterable {
    case one
    case two
    case four
}

extension ImagesPerPageCount {
    var count: Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .four:
            return 3
        }
    }
    
    var image: UIImage {
        switch self {
        case .one:
            return UIImage(systemName: "square")!
        case .two:
            return UIImage(systemName: "square.split.1x2")!
        case .four:
            return UIImage(systemName: "square.split.2x2")!
        }
    }
}

enum ImageContentType: Int, CaseIterable {
    case colorDocument, colorPhoto, bwDocument, bwPhoto
}

extension ImageContentType {
    var title: String {
        switch self {
        case .colorDocument:
            return "Color Document"
        case .colorPhoto:
            return "Color Photo"
        case .bwDocument:
            return "Black & White Document"
        case .bwPhoto:
            return "Black & White Photo"
        }
    }
}
