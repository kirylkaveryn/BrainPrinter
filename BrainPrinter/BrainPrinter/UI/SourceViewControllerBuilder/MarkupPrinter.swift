//
//  MarkupPrinter.swift
//  BrainPrinter
//
//  Created by Kirill on 2.09.22.
//

import Foundation
import PDFKit

class MarkupPrinter {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    func make() -> UIPrintInteractionController {
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
    }
}
