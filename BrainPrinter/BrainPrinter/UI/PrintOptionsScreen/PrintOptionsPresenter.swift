//
//  PrintOptionsPresenter.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation

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
}
