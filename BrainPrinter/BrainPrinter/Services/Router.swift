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
    init(navigationController: UINavigationController, builder: SourceViewControllerBuilderProtocol)
    func goTo(sourceType: SourceType)
    func sendToPrinter(images: [UIImage])
    
}

class Router: NSObject, RouterProtocol {
    private let navigationController: UINavigationController
    private var resultResource: [UIImage] = []
    private var completion: (([UIImage]) -> Void)?
    private var builder: SourceViewControllerBuilderProtocol
    
    required init(navigationController: UINavigationController, builder: SourceViewControllerBuilderProtocol = SourceViewControllerBuilder()) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func goTo(sourceType: SourceType) {
        let sourceViewController = builder.getSourceViewContoller(
            sourceType: sourceType,
            completion: { [weak self] images in
            guard let self = self else { return }
            self.navigationController.dismiss(animated: true)
//            self.sendToPrinter(images: images)
            self.goToPrintingOptions() // FIXME:
        })
        navigationController.present(sourceViewController, animated: true)
    }
    
    func sendToPrinter(images: [UIImage]) {
        let printerController = builder.getPrinterViewContoller(images: images) { [weak self] images in
            guard let self = self else { return }
            self.navigationController.dismiss(animated: true)
        }
        printerController.present(animated: true)
    }
    
    func goToPrintingOptions() {
        let printingOptionsViewController = TableViewController()
        navigationController.pushViewController(printingOptionsViewController, animated: true)
    }
    
    private func cleanUpResultResource() {
        resultResource = []
    }
    
}
