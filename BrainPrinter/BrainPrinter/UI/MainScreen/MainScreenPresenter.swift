//
//  MainScreenPresenter.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var dataSource: [MainScreenCellViewModel] { get }
    
    func aboutButtonDidTap()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    private var router: RouterProtocol
    private let sourceTypes: [SourceType]
    
    var dataSource: [MainScreenCellViewModel] {
        get {
            sourceTypes.map { parseToCellModel(sourceType: $0) }
        }
    }
    
    init(sourceTypes: [SourceType] = SourceType.allCases, router: Router) {
        self.sourceTypes = sourceTypes
        self.router = router
    }
    
    func aboutButtonDidTap() {
        router.goToAboutScreen()
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
