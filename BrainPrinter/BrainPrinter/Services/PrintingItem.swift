//
//  PrintingItem.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation
import UIKit

enum ImageOrientation {
    case portrait, landscape
}

enum ImagesPerPageCount: Int {
    case one = 1
    case two = 2
    case four = 4
}

enum ImageContentType {
    case colorDocument, colorPhoto, bwDocument, bwPhoto
}

struct PrintingItem {
    var images: [UIImage]
    var imageOrientation: ImageOrientation
    var imagesPerPageCont: ImagesPerPageCount
    var imageContentType: ImageContentType
    var numberOfCopies: UInt
}
