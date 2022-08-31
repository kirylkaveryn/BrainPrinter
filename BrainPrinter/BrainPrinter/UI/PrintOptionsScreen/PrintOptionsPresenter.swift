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

public let kPrintingOptionOrientaionKey = "kPrintingOptionOrientaionKey"
public let kPrintingOptionImagesPerPageKey = "kPrintingOptionImagesPerPageKey"
public let kPrintingOptionImageContentTypeKey = "kPrintingOptionImageContentTypeKey"
public let kPrintingOptionImagesCountTypeKey = "kPrintingOptionImagesCountTypeKey"

protocol PrintOptionsPresenterProtocol: AnyObject {
    var delegate: PrintOptionsDelegate? { get set }
    var dataSource: [PrintOptionsSectionContentProtocol] { get }
    var printingItem: PrintingItem { get set }
}

protocol PrintOptionsDelegate: AnyObject {}

class PrintOptionsPresenter: PrintOptionsPresenterProtocol {
    
    weak var delegate: PrintOptionsDelegate? {
        didSet {
            startPrintingOptionsObserving()
        }
    }
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
        NotificationCenter.default.addObserver(forName: kPrintingOptionOrientaionNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            guard let userInfo = notification.userInfo,
                    let selectedIndex = userInfo[kPrintingOptionOrientaionKey] as? Int,
                    let orientation = ImageOrientation(rawValue: selectedIndex) else { return }
            self.printingItem.imageOrientation = orientation
        }
        NotificationCenter.default.addObserver(forName: kPrintingOptionImagesPerPageCountNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            guard let userInfo = notification.userInfo,
                    let selectedIndex = userInfo[kPrintingOptionImagesPerPageKey] as? Int,
                    let count = ImagesPerPageCount(rawValue: selectedIndex) else { return }
            self.printingItem.imagesPerPageCont = count
        }
        NotificationCenter.default.addObserver(forName: kPrintingOptionImageContentTypeNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
        }
        NotificationCenter.default.addObserver(forName: kPrintingOptionImagesCountNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
