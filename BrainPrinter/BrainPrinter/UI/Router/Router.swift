//
//  Router.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import Foundation
import UIKit

/// Router protocol is used to create objects that can handle navigation between screens.

protocol RouterProtocol {
    init(navigationController: UINavigationController, builder: SourceViewControllerBuilderProtocol)
    func goTo(sourceType: SourceType)
    func sendToPrinter(_ object: PrintingObject)
}

/// An object that incapsulate navigation beween screens.
///
/// Router configure and present ViewControllers.
/// To use Router you shold provide NavigationController and SourceViewControllerBuilder
/// ```
/// required init(navigationController: UINavigationController, builder: SourceViewControllerBuilderProtocol)
/// ```

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
                self.goToPrintOptions(sourceType: sourceType, images: images)
                }) else { return }
            navigationController.present(sourceViewController, animated: true)
        }
    }
    
    func goToPrintOptions(sourceType: SourceType, images: [UIImage]) {
        let printOptionsPresenter = PrintOptionsPresenter(sourceType: sourceType, router: self, images: images)
        let printOptionsViewController = PrintOptionsViewController(presenter: printOptionsPresenter)
        navigationController.pushViewController(printOptionsViewController, animated: true)
    }
    
    func sendToPrinter(_ object: PrintingObject) {
        let printerController = Printer(print: object).make()
        printerController.present(animated: true)
    }

}
