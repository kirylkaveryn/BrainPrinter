//
//  PrintingItem.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation
import UIKit

struct PrintingItem {
    var images: [UIImage]
    var imageOrientation: ImageOrientation = .portrait
    var imagesPerPageCont: ImagesPerPageCount = .one
    var imageContentType: ImageContentType = .colorDocument
    var numberOfCopies: Int = 1
}
