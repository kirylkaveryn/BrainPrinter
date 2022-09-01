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
    private let resourceService: ResourceServiceProtocol
    
    var dataSource: [MainScreenCellViewModel] {
        get {
            resourceService.sourceTypes.map { parseToCellModel(sourceType: $0) }
        }
    }
    
    init(resourceService: ResourceServiceProtocol, router: Router) {
        self.resourceService = resourceService
        self.router = router
    }
    
    /// Parse SourceType case  to CellModel with additional handler of cell pressing
    private func parseToCellModel(sourceType: SourceType) -> MainScreenCellViewModel {
        let cellModel = MainScreenCellViewModel(
            image: sourceType.image,
            title: sourceType.content.title,
            subtitle: sourceType.content.subtitle,
            cellDidPress: { [weak self] in
                guard let self = self else { return }
                self.router.goTo(sourceType: sourceType)
            })
        return cellModel
    }
}
