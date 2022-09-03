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
    func goToAboutScreen()
    func sendToPrinter(_ object: PrintingObject)
    func openURL(url: URL?)
    func sendFeedback(recipient: URL?, message: String?)
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
    private var mailComposer: MailComposer?

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
    
    func goToAboutScreen() {
        let presenter = AboutScreenPresenter(router: self)
        let viewController = AboutScreenViewController(presenter: presenter)
        let innerNavigationController = UINavigationController(rootViewController: viewController)
        navigationController.present(innerNavigationController, animated: true)
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
    
    func openURL(url: URL?) {
        guard let url = url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func sendFeedback(recipient: URL?, message: String?) {
        mailComposer = MailComposer(recipient: recipient, message: message)
        guard let mailVC = mailComposer?.make() else { return }
        // visibleViewController is used, because of MailVC is shown modally over other modal VC
        navigationController.visibleViewController?.present(mailVC, animated: true)
    }

}
