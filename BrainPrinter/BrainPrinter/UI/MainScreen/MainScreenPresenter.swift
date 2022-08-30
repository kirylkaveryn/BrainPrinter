//
//  MainScreenPresenter.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var delegate: MainScreenDelegate? { get set }
    var resourceManager: ResourceManagerProtocol { get }
}

protocol MainScreenDelegate: AnyObject {
    func updateView()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    let resourceManager: ResourceManagerProtocol
    weak var delegate: MainScreenDelegate?
    
    init(resourceManager: ResourceManagerProtocol) {
        self.resourceManager = resourceManager
    }
}
