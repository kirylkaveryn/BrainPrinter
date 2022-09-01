//
//  Printer.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation
import PDFKit

class Printer {
    
    private var text: String? = nil
    private var printingItem: PrintingItem? = nil
    
    init(printingItem: PrintingItem) {
        self.printingItem = printingItem
    }

    init(text: String) {
        self.text = text
    }
    
    func make() -> UIPrintInteractionController {
        if let text = text {
            let textWithoutOccerencies = text.replacingOccurrences(of: "\n", with: "<br />")
            let printerController = UIPrintInteractionController.shared
            let format = UIMarkupTextPrintFormatter(markupText: textWithoutOccerencies)
            format.perPageContentInsets = .init(top: 72, left: 72, bottom: 72, right: 72)
            let printInfo = UIPrintInfo(dictionary: nil)
            printInfo.outputType = .general
            printerController.printInfo = printInfo
            printerController.showsNumberOfCopies = true
            printerController.printFormatter = format
            return printerController
        } else {
            let printingItem = printingItem!
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
}
