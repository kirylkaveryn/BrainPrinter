//
//  PrintingItem.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation
import UIKit

/// This object represents information of content sent to printer.
enum PrintingObject {
    case images(PrintingImages)
    case poster(PrintingPoster)
    case text(PrintingText)
}

struct PrintingImages {
    var images: [UIImage]
    var imageOrientation: ImageOrientation = .portrait
    var imagesPerPageCount: ImagesPerPageCount = .one
    var imageContentType: ImageContentType = .colorDocument
    var numberOfCopies: Int = 1
}

struct PrintingPoster {
    var image: UIImage
    var pagesWide: Int
    var imageContentType: ImageContentType = .colorDocument
    var numberOfCopies: Int = 1
}

struct PrintingText {
    var text: String
}
