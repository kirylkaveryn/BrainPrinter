//
//  PrintOptionsPresenter.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation

protocol PrintOptionsPresenterProtocol: AnyObject {
    var dataSource: [PrintOptionsSectionContentModel] { get }
    var printingItem: PrintingImages { get set }
    func sendToPrinter()
}

class PrintOptionsPresenter: PrintOptionsPresenterProtocol {
    private let router: RouterProtocol
    private let resourceService: ResourceServiceProtocol
    
    var printingItem: PrintingImages
    var dataSource: [PrintOptionsSectionContentModel] {
        get {
            resourceService.printOptions.map { parseOptionsToSectionModel(printOptions: $0) }
        }
    }
    
    init(resourceService: ResourceServiceProtocol, router: RouterProtocol, printingItem: PrintingImages) {
        self.resourceService = resourceService
        self.router = router
        self.printingItem = printingItem
    }
    
    func sendToPrinter() {
        let printingObject = PrintableObject.image(printingItem)
        router.sendToPrinter(printingObject)
    }
    
    private func parseOptionsToSectionModel(printOptions: PrintOptions) -> PrintOptionsSectionContentModel {
        let sectionTitle = printOptions.title
        let printOptions = printOptions
        let numberOfRows: Int
        let rowHeight: Int
        let valueDidChangeHandler: ((Int) -> ())?
        
        switch printOptions {
        case .imageOrientaion:
            numberOfRows = 1
            rowHeight = 100
            valueDidChangeHandler = { [weak self] newValue in
                guard let self = self else { return }
                let orientation = ImageOrientation(rawValue: newValue) ?? .landscape
                self.printingItem.imageOrientation = orientation
            }
        case .imagesPerPage:
            numberOfRows = 1
            rowHeight = 100
            valueDidChangeHandler = { [weak self] newValue in
                guard let self = self else { return }
                let count = ImagesPerPageCount(rawValue: newValue) ?? .one
                self.printingItem.imagesPerPageCount = count
            }
        case .imageContentType(let contentTypes):
            numberOfRows = contentTypes.count
            rowHeight = 50
            valueDidChangeHandler = { [weak self] newValue in
                guard let self = self else { return }
                let contentType = ImageContentType(rawValue: newValue) ?? .colorDocument
                self.printingItem.imageContentType = contentType
            }
        case .imagesCount:
            numberOfRows = 0 // FIXME: - remove all prop
            rowHeight = 50
            valueDidChangeHandler = { [weak self] newValue in
                guard let self = self else { return }
                let count = newValue
                self.printingItem.numberOfCopies = count
            }
        }
        
        let section = PrintOptionsSectionContentModel(
            sectionTitle: sectionTitle,
            printOptions: printOptions,
            numberOfRows: numberOfRows,
            rowHeight: rowHeight,
            valueDidChangeHandler: valueDidChangeHandler)
        return section
        
    }
}
