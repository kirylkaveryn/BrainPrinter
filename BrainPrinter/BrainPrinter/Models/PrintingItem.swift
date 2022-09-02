//
//  PrintingItem.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation
import UIKit

/// This object represents information of content sent to printer

enum PrintableObject {
    case image(PrintingImages)
    case text(PrintingText)
}

struct PrintingImages {
    var images: [UIImage]
    var imageOrientation: ImageOrientation = .portrait
    var imagesPerPageCount: ImagesPerPageCount = .one
    var imageContentType: ImageContentType = .colorDocument
    var numberOfCopies: Int = 1
}

struct PrintingText {
    var text: String
}
