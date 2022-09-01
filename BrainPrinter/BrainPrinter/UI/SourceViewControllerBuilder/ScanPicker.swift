//
//  ScanPicker.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation
import VisionKit

class ScanPicker: NSObject, SourceProtocol {
    private var dismissScreenCompletion: DismissScreenCompletion
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(dismissScreenCompletion: @escaping DismissScreenCompletion) {
        self.dismissScreenCompletion = dismissScreenCompletion
    }
    
    func make() -> UIViewController {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = self
        return scannerViewController
    }
}

extension ScanPicker: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        var images: [UIImage] = []
        for pageNumber in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            images.append(image)
        }
        dismissScreenCompletion(images)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true)
    }
}

