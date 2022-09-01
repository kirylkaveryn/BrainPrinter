//
//  Router.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import Foundation
import UIKit

protocol RouterProtocol {
    init(navigationController: UINavigationController, builder: SourceViewControllerBuilderProtocol)
    func goTo(sourceType: SourceType)
    func sendToPrinter(printingItem: PrintingItem)
    func sendToPrinter(text: String)
}

class Router: NSObject, RouterProtocol {
    private let navigationController: UINavigationController
    private var completion: (([UIImage]) -> Void)?
    private var builder: SourceViewControllerBuilderProtocol
    
    required init(navigationController: UINavigationController, builder: SourceViewControllerBuilderProtocol = SourceViewControllerBuilder()) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func goTo(sourceType: SourceType) {
        if sourceType == .note {
            let notePresenter = NotePresenter(router: self)
            let noteViewController = NoteViewController(presenter: notePresenter)
            navigationController.pushViewController(noteViewController, animated: true)
        } else {
            guard let sourceViewController = builder.getSourceViewContoller(
                sourceType: sourceType,
                dismissScreenCompletion: { [weak self] images in
                guard let self = self else { return }
                self.navigationController.dismiss(animated: true)
                self.goToPrintOptions(images: images)
                }) else { return }
            navigationController.present(sourceViewController, animated: true)
        }
    }
    
    func goToPrintOptions(images: [UIImage]) {
        let printingItem = PrintingItem(images: images)
        let printOptionsPresenter = PrintOptionsPresenter(resourceService: ResourceService(), router: self, printingItem: printingItem)
        let printOptionsViewController = PrintOptionsViewController(presenter: printOptionsPresenter)
        navigationController.pushViewController(printOptionsViewController, animated: true)
    }
    
    func sendToPrinter(printingItem: PrintingItem) {
        let printerController = Printer(printingItem: printingItem).make()
        printerController.present(animated: true)
    }
    
    func sendToPrinter(text: String) {
        let printerController = Printer(text: text).make()
        printerController.present(animated: true)
    }

}
