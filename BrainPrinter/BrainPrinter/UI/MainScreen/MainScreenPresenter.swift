//
//  MainScreenPresenter.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var delegate: MainScreenDelegate? { get set }
    var dataSource: [MainScreenResourceProtocol] { get }
}

protocol MainScreenDelegate: AnyObject {}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    private let resourceManager: ResourceManagerProtocol
    weak var delegate: MainScreenDelegate?
    
    var dataSource: [MainScreenResourceProtocol] {
        get {
            resourceManager.mainScreenCollectionDataSource
        }
    }
    
    init(resourceManager: ResourceManagerProtocol) {
        self.resourceManager = resourceManager
    }
}
