//
//  PrintOptionsPresenter.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation

protocol PrintOptionsPresenterProtocol: AnyObject {
    var dataSource: [PrintOptionsSectionContentProtocol] { get }
    var printingItem: PrintingItem { get set }
    func sendToPrinter()
}

class PrintOptionsPresenter: PrintOptionsPresenterProtocol {
    private let router: RouterProtocol
    private let resourceManager: ResourceManagerProtocol
    
    var printingItem: PrintingItem
    var dataSource: [PrintOptionsSectionContentProtocol] {
        get {
            resourceManager.printingOptionsDataSource // FIXME: - из ресур менеджера вернуть только ДАННЫЕ и сконфигурировать ячейки тут
        }
    }
    
    init(resourceManager: ResourceManagerProtocol, router: RouterProtocol, printingItem: PrintingItem) {
        self.resourceManager = resourceManager
        self.router = router
        self.printingItem = printingItem
    }
    
    func sendToPrinter() {
        router.sendToPrinter(printingItem: printingItem)
    }
}
