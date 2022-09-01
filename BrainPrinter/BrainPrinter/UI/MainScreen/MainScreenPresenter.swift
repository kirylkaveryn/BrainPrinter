//
//  MainScreenPresenter.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var dataSource: [MainScreenCellViewModel] { get }
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    private var router: RouterProtocol
    private let resourceManager: ResourceManagerProtocol
    
    var dataSource: [MainScreenCellViewModel] {
        get {
            resourceManager.mainScreenCollectionDataSource.map { parseContentItemToCellModel(dataModel: $0) }
        }
    }
    
    init(resourceManager: ResourceManagerProtocol, router: Router) {
        self.resourceManager = resourceManager
        self.router = router
    }
    
    /// Parse Initial Content  to CellModel with additional handler of cell pressing
    private func parseContentItemToCellModel(dataModel: MainScreenItemContentProtocol) -> MainScreenCellViewModel {
        let cellModel = MainScreenCellViewModel(
            image: dataModel.image,
            title: dataModel.title,
            subtitle: dataModel.subtitle,
            sourceType: dataModel.sourceType,
            cellDidPress: { [weak self] in
                guard let self = self else { return }
                self.router.goTo(sourceType: dataModel.sourceType)
            })
        return cellModel
    }
}
