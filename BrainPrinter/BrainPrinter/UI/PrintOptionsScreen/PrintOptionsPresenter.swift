//
//  PrintOptionsPresenter.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation

public let kPrintingOptionOrientaionNotification = Notification.Name("kPrintingOptionOrientaionNotification")
public let kPrintingOptionImagesPerPageCountNotification = Notification.Name("kPrintingOptionImagesPerPageCountNotification")
public let kPrintingOptionImageContentTypeNotification = Notification.Name("kPrintingOptionImageContentTypeNotification")
public let kPrintingOptionImagesCountNotification = Notification.Name("kPrintingOptionImagesCountNotification")

protocol PrintOptionsPresenterProtocol: AnyObject {
    var delegate: PrintOptionsDelegate? { get set }
    var dataSource: [PrintOptionsSectionContentProtocol] { get }
    var printingItem: PrintingItem { get set }
}

protocol PrintOptionsDelegate: AnyObject {}

class PrintOptionsPresenter: PrintOptionsPresenterProtocol {
    
    weak var delegate: PrintOptionsDelegate?
    private let resourceManager: ResourceManagerProtocol
    var printingItem: PrintingItem
    
    var dataSource: [PrintOptionsSectionContentProtocol] {
        get {
            resourceManager.printingOptionsDataSource
        }
    }
    
    init(resourceManager: ResourceManagerProtocol, printingItem: PrintingItem) {
        self.resourceManager = resourceManager
        self.printingItem = printingItem
    }
    
    private func startPrintingOptionsObserving() {
        NotificationCenter.default.addObserver(forName: kPrintingOptionOrientaionNotification, object: nil, queue: nil) { notification in
            print(notification)
        }
        NotificationCenter.default.addObserver(forName: kPrintingOptionImagesPerPageCountNotification, object: nil, queue: nil) { notification in
            print(notification)
        }
        NotificationCenter.default.addObserver(forName: kPrintingOptionImageContentTypeNotification, object: nil, queue: nil) { notification in
            print(notification)
        }
        NotificationCenter.default.addObserver(forName: kPrintingOptionImagesCountNotification, object: nil, queue: nil) { notification in
            print(notification)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
