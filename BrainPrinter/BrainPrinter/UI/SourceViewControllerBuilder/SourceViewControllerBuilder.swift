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
    func getSourceViewContoller(sourceType: SourceType, dismissScreenCompletion: @escaping DismissScreenCompletion) -> UIViewController?
    func getPrinterViewContoller(printingItem: PrintingItem, dismissScreenCompletion: @escaping DismissScreenCompletion) -> UIPrintInteractionController
}

class SourceViewControllerBuilder: NSObject, SourceViewControllerBuilderProtocol {
    
    private var source: SourceProtocol?
    
    func getSourceViewContoller(sourceType: SourceType, dismissScreenCompletion: @escaping DismissScreenCompletion) -> UIViewController? {
        switch sourceType {
        case .photo:
            source = PhotoPicker(dismissScreenCompletion: dismissScreenCompletion)
        case .document:
            source = DocumentPicker(dismissScreenCompletion: dismissScreenCompletion)
        case .scan:
            source = ScanPicker(dismissScreenCompletion: dismissScreenCompletion)
        case .note:
            // FIXME: add VC
            source = PhotoPicker(dismissScreenCompletion: dismissScreenCompletion)
        case .poster:
            source = SinglePhotoPicker(dismissScreenCompletion: dismissScreenCompletion)
        }
        return source?.make() ?? nil
    }
    
    // MARK: - UIPrintInteractionController
    func getPrinterViewContoller(printingItem: PrintingItem, dismissScreenCompletion: @escaping DismissScreenCompletion) -> UIPrintInteractionController {
        Printer(printingItem: printingItem).make()
    }
}
