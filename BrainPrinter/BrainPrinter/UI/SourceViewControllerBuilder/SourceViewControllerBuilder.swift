//
//  SourceViewControllerConfigurator.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation
import UIKit
import PDFKit

protocol SourceViewControllerBuilderProtocol: AnyObject {
    func getSourceViewContoller(sourceType: SourceType, dismissScreenCompletion: @escaping DismissScreenCompletion) -> UIViewController?
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
        case .poster:
            source = SinglePhotoPicker(dismissScreenCompletion: dismissScreenCompletion)
        default:
            return nil
        }
        return source?.make() ?? nil
    }

}
