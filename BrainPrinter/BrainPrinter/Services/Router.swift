//
//  Router.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import Foundation
import UIKit
import PhotosUI
import VisionKit
import PDFKit

protocol RouterProtocol {
    init(navigationController: UINavigationController)
    
    func goTo(sourceType: SourceType)
}

class Router: NSObject, RouterProtocol {
    private let navigationController: UINavigationController
    private var resultResource: [UIImage] = []
    private var completion: (([UIImage]) -> Void)?
    private var controllerBuilder = SourceViewControllerBuilder()
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goTo(sourceType: SourceType) {
        guard let sourceViewController = controllerBuilder.confugureViewControllerWith(sourceType: sourceType,
                                                                             completion: { [weak self] images in
            guard let self = self else { return }
            self.navigationController.dismiss(animated: true)
            self.sendToPrinter(images: images)
        }) else {
            return
        }
        navigationController.present(sourceViewController, animated: true)
    }
    
    func sendToPrinter(images: [UIImage]) {
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .photo
        printController.printInfo = printInfo
        printController.printingItems = images
        printController.present(animated: true)
    }
    
    private func cleanUpResultResource() {
        resultResource = []
    }
    
}
