//
//  SourceViewControllerConfigurator.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation
import UIKit
import PhotosUI
import VisionKit
import PDFKit

protocol SourceViewControllerBuilderProtocol: AnyObject {
    func getSourceViewContoller(sourceType: SourceType, completion: @escaping ([UIImage]) -> Void) -> UIViewController
    func getPrinterViewContoller(printingItem: PrintingItem, completion: @escaping ([UIImage]) -> Void) -> UIPrintInteractionController
}

class SourceViewControllerBuilder: NSObject, SourceViewControllerBuilderProtocol {
    
    private var completion: (([UIImage]) -> Void)!

    func getSourceViewContoller(sourceType: SourceType, completion: @escaping ([UIImage]) -> Void) -> UIViewController {
        self.completion = completion
        var sourceViewController: UIViewController
        switch sourceType {
        case .photo:
            var configuration = PHPickerConfiguration()
            configuration.filter = .images
            configuration.selectionLimit = 0
            let photosPickerViewController = PHPickerViewController(configuration: configuration)
            photosPickerViewController.delegate = self
            sourceViewController = photosPickerViewController
        case .document:
            let documentPickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: [.image, .text, .html, .pdf, .png, .jpeg, .bmp,], asCopy: true)
            documentPickerViewController.delegate = self
            documentPickerViewController.allowsMultipleSelection = false
            sourceViewController = documentPickerViewController
        case .scan:
            let scannerViewController = VNDocumentCameraViewController()
            scannerViewController.delegate = self
            sourceViewController = scannerViewController
        case .note:
            sourceViewController = UIViewController() // FIXME: add VC
            
        case .poster:
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.delegate = self
            sourceViewController = imagePickerViewController
        }
        return sourceViewController
    }
    
    // MARK: - UIPrintInteractionController
    func getPrinterViewContoller(printingItem: PrintingItem, completion: @escaping ([UIImage]) -> Void) -> UIPrintInteractionController {
        self.completion = completion
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


// MARK: - UIImagePickerControllerDelegate
extension SourceViewControllerBuilder: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = UIImage()
        
        if let possibleImage = info[.editedImage] as? UIImage {
            image = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            image = possibleImage
        }
        
        completion([image])
    }
}

// MARK: - PHPickerViewControllerDelegate
extension SourceViewControllerBuilder: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        var images: [UIImage] = []
        let uploadGroup = DispatchGroup()
        if !results.isEmpty {
            for result in results {
                uploadGroup.enter()
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        if let image = image as? UIImage {
                            images.append(image)
                        }
                        uploadGroup.leave()
                    }
                }
            }
        }
        uploadGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.completion(images)
            }
        }
    }
}

// MARK: - VNDocumentCameraViewControllerDelegate
extension SourceViewControllerBuilder: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        var images: [UIImage] = []
        for pageNumber in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            images.append(image)
        }
        completion(images)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        completion([])
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        completion([])
    }
}

// MARK: - UIDocumentPickerDelegate
extension SourceViewControllerBuilder: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let pickedURL = urls.first else {
            completion([])
            return
        }

        // check if image imported
        if let image = UIImage(contentsOfFile: pickedURL.path) {
            completion([image])
        }
        
        // check if PDF imported
        let images = getImagesFromPDF(url: pickedURL)
        if images.count > 0 {
            completion(images)
        }
    }
    
    /// Converts and returns PDFDocument from profvided URL to Array of UIImage
    private func getImagesFromPDF(url: URL) -> [UIImage] {
        var images: [UIImage] = []
        if let document = CGPDFDocument(url as CFURL) {
            for index in 1..<document.numberOfPages + 1 {
                guard let page = document.page(at: index) else { return images }
                let pageRect = page.getBoxRect(.mediaBox)
                let renderer = UIGraphicsImageRenderer(size: pageRect.size)
                let image = renderer.image { ctx in
                    UIColor.white.set()
                    ctx.fill(pageRect)
                    
                    ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
                    ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                    
                    ctx.cgContext.drawPDFPage(page)
                }
                images.append(image)
            }
        }
        return images
    }
}
