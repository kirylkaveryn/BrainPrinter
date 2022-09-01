//
//  Printer.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation
import PDFKit

class Printer {
    var printingItem: PrintingItem
    
    init(printingItem: PrintingItem) {
        self.printingItem = printingItem
    }
    
    func make() -> UIPrintInteractionController {
        let printerController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        
        switch printingItem.imageOrientation {
        case .portrait:
            printInfo.orientation = .portrait
        case .landscape:
            printInfo.orientation = .landscape
        }
        
        switch printingItem.imageContentType {
        case .colorDocument:
            printInfo.outputType = .general
        case .colorPhoto:
            printInfo.outputType = .photo
        case .bwDocument:
            printInfo.outputType = .grayscale
        case .bwPhoto:
            printInfo.outputType = .photoGrayscale
        }
        
        printerController.printInfo = printInfo
        printerController.showsNumberOfCopies = true
        
        printerController.printingItems = printingItem.images
        return printerController
    }
}
