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
/// You can initialize Printer instance with PrintingObject.
/// To get view controller use make().
/// ```
/// let printerViewController = Printer(print: object).make()
/// ```

class Printer {
    
    private var object: PrintingObject
    
    init(print object: PrintingObject) {
        self.object = object
    }
    
    func make() -> UIPrintInteractionController {
        
        switch object {
        case .images(let printingImages):
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
            
            // Markup formatter is used for formatting Strins
            let format = UIMarkupTextPrintFormatter(markupText: textWithoutOccerencies)
            format.perPageContentInsets = .init(top: 72, left: 72, bottom: 72, right: 72)
            
            let printInfo = UIPrintInfo(dictionary: nil)
            printInfo.outputType = .general
   
            printerController.printInfo = printInfo
            printerController.showsNumberOfCopies = true
            printerController.printFormatter = format
            return printerController
        case .poster(let printingPoster):
            let printerController = UIPrintInteractionController.shared
            
            let printingImages = splitImage(image: printingPoster.image,
                                            row: printingPoster.pagesWide,
                                            column: printingPoster.pagesWide)
            
            let printInfo = UIPrintInfo(dictionary: nil)
            
            switch printingPoster.imageContentType {
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
            printerController.printingItems = printingImages
            return printerController
        }
    }
    
    
    /// Split image into provides number of parts.
    private func splitImage(image: UIImage, row: Int, column: Int) -> [UIImage] {

        // get the size of an image
        let height =  (image.size.height) / CGFloat (row)
        let width =  (image.size.width) / CGFloat (column)
        let scale = (image.scale)

        var resultImages: [UIImage] = []
        // iterate through the rows
        for y in 0..<row {
            var yArr: [UIImage] = []
            for x in 0..<column {
                // draw every part of an image to separate image
                UIGraphicsBeginImageContextWithOptions(CGSize(width:width, height:height), false, 0)
                let cgImage = image.cgImage?.cropping(to:  CGRect.init(x: CGFloat(x) * width * scale, y:  CGFloat(y) * height * scale  , width: (width * scale) , height: (height * scale)) )
                let newImg = UIImage.init(cgImage: cgImage!)
                yArr.append(newImg)
                UIGraphicsEndImageContext();
            }
            resultImages.append(contentsOf: yArr)
        }
        return resultImages
    }
}
