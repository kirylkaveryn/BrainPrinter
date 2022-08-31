//
//  PrintOptionsPresenter.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation

protocol PrintOptionsPresenterProtocol: AnyObject {
    var delegate: PrintOptionsDelegate? { get set }
//    var dataSource: [PrintOptionsResourceProtocol] { get }
}

protocol PrintOptionsDelegate: AnyObject {}

class PrintOptionsPresenter: PrintOptionsPresenterProtocol {
    
    private let resourceManager: ResourceManagerProtocol
    weak var delegate: PrintOptionsDelegate?
    
//    var dataSource: [PrintOptionsResourceProtocol] {
//        get {
////            resourceManager.mainScreenCollectionDataSource
//        }
//    }
    
    init(resourceManager: ResourceManagerProtocol) {
        self.resourceManager = resourceManager
    }
}
