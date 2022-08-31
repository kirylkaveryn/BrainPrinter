//
//  MainScreenPresenter.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var delegate: MainScreenDelegate? { get set }
    var dataSource: [MainScreenItemContentProtocol] { get }
}

protocol MainScreenDelegate: AnyObject {}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    private let resourceManager: ResourceManagerProtocol
    weak var delegate: MainScreenDelegate?
    
    var dataSource: [MainScreenItemContentProtocol] {
        get {
            resourceManager.mainScreenCollectionDataSource
        }
    }
    
    init(resourceManager: ResourceManagerProtocol) {
        self.resourceManager = resourceManager
    }
}
