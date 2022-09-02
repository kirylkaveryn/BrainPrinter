//
//  DocumentPicker.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation
import UIKit

/// An object that build and configure UIDocumentPickerViewController.
///
/// To get view controller use make().
/// ```
/// let source = DocumentPicker(dismissScreenCompletion: dismissScreenCompletion).make()
/// ```

class DocumentPicker: NSObject, SourceProtocol {
    private var dismissScreenCompletion: DismissScreenCompletion
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(dismissScreenCompletion: @escaping DismissScreenCompletion) {
        self.dismissScreenCompletion = dismissScreenCompletion
    }
    
    func make() -> UIViewController {
        let documentPickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: [.image, .text, .html, .pdf, .png, .jpeg, .bmp,], asCopy: true)
        documentPickerViewController.delegate = self
        documentPickerViewController.allowsMultipleSelection = false
        return documentPickerViewController
    }
}

extension DocumentPicker: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let pickedURL = urls.first else {
            dismissScreenCompletion([])
            return
        }

        // check if image imported
        if let image = UIImage(contentsOfFile: pickedURL.path) {
            dismissScreenCompletion([image])
        }
        
        // check if PDF imported
        let images = getImagesFromPDF(url: pickedURL)
        if images.count > 0 {
            dismissScreenCompletion(images)
        }
    }
    
    /// Converts and returns PDFDocument from profvided URL to Array of UIImage
    private func getImagesFromPDF(url: URL) -> [UIImage] {
        var images: [UIImage] = []
        if let document = CGPDFDocument(url as CFURL) {
            // iterate for every page of PDF document
            for index in 1..<document.numberOfPages + 1 {
                // get page
                guard let page = document.page(at: index) else { return images }
                let pageRect = page.getBoxRect(.mediaBox)
                let renderer = UIGraphicsImageRenderer(size: pageRect.size)
                // draw page to image with renderer
                let image = renderer.image { ctx in
                    UIColor.white.set()
                    ctx.fill(pageRect)
                    
                    ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
                    ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                    
                    ctx.cgContext.drawPDFPage(page)
                }
                // add image to array
                images.append(image)
            }
        }
        return images
    }
}
