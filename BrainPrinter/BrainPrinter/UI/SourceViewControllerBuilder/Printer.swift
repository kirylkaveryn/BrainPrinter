//
//  Printer.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation
import PDFKit

/// An object that build and configure UIPrintInteractionController.
///
/// You can initialize Printer instance with PrintableObject.
/// To get view controller use make().
/// ```
/// let printerViewController = Printer(print: object).make()
/// ```

class Printer {
    
    private var object: PrintableObject
    
    init(print object: PrintableObject) {
        self.object = object
    }
    
    func make() -> UIPrintInteractionController {
        
        switch object {
        case .image(let printingImages):
            let printerController = UIPrintInteractionController.shared
            let printInfo = UIPrintInfo(dictionary: nil)
            
            switch printingImages.imageOrientation {
            case .portrait:
                printInfo.orientation = .portrait
            case .landscape:
                printInfo.orientation = .landscape
            }
            
            switch printingImages.imageContentType {
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
            
            printerController.printingItems = printingImages.images
            return printerController
        case .text(let printingText):
            let textWithoutOccerencies = printingText.text.replacingOccurrences(of: "\n", with: "<br />")
            let printerController = UIPrintInteractionController.shared
            let format = UIMarkupTextPrintFormatter(markupText: textWithoutOccerencies)
            format.perPageContentInsets = .init(top: 72, left: 72, bottom: 72, right: 72)
            let printInfo = UIPrintInfo(dictionary: nil)
            printInfo.outputType = .general
            printerController.printInfo = printInfo
            printerController.showsNumberOfCopies = true
            printerController.printFormatter = format
            return printerController
        }
    }
}
