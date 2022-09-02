//
//  PrintOptionsPresenter.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import Foundation
import UIKit

protocol PrintOptionsPresenterProtocol: AnyObject {
    var dataSource: [PrintOptionsSectionContentModel] { get }
    
    var images: [UIImage] { get }
    var imageOrientation: ImageOrientation { get }
    var imagesPerPageCount: ImagesPerPageCount { get }
    var imageContentType: ImageContentType { get }
    var numberOfCopies: Int { get }
    var pagesWide: Int { get }
    
    func sendToPrinter()
}

class PrintOptionsPresenter: PrintOptionsPresenterProtocol {
    private let router: RouterProtocol
    private let printOptions: [PrintOptions]
    private let sourceType: SourceType

    var images: [UIImage]
    var imageOrientation: ImageOrientation = .portrait
    var imagesPerPageCount: ImagesPerPageCount = .one
    var imageContentType: ImageContentType = .colorDocument
    var numberOfCopies: Int = 1
    var pagesWide: Int = 1
    
    var dataSource: [PrintOptionsSectionContentModel] {
        get {
            printOptions.map { parseOptionsToSectionModel(printOptions: $0) }
        }
    }
    
    init(sourceType: SourceType, router: RouterProtocol, images: [UIImage]) {
        self.router = router
        self.images = images
        self.sourceType = sourceType
        
        // setup initail printing options for different image source types
        switch sourceType {
        case .poster:
            self.printOptions = [
                .imageContentType(ImageContentType.allCases),
                .posterShouldBe(pagesWide: 3),
                .preview
            ]
        default:
            self.printOptions = [
                .imageOrientaion(ImageOrientation.allCases),
                .imagesPerPage(ImagesPerPageCount.allCases),
                .imageContentType(ImageContentType.allCases),
            ]
        }
    }
    
    func sendToPrinter() {
        let printingObject: PrintingObject
        switch sourceType {
        case .poster:
            let poster = PrintingPoster(image: images[0],
                                        pagesWide: pagesWide,
                                        imageContentType: imageContentType,
                                        numberOfCopies: numberOfCopies)
            printingObject = PrintingObject.poster(poster)

        default:
            let printingImages = PrintingImages(images: images,
                                                imageOrientation: imageOrientation,
                                                imagesPerPageCount: imagesPerPageCount,
                                                imageContentType: imageContentType,
                                                numberOfCopies: numberOfCopies)
            printingObject = PrintingObject.images(printingImages)
        }
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
                self.imageOrientation = orientation
            }
        case .imagesPerPage:
            numberOfRows = 1
            rowHeight = 100
            valueDidChangeHandler = { [weak self] newValue in
                guard let self = self else { return }
                let count = ImagesPerPageCount(rawValue: newValue) ?? .one
                self.imagesPerPageCount = count
            }
        case .imageContentType(let contentTypes):
            numberOfRows = contentTypes.count
            rowHeight = 50
            valueDidChangeHandler = { [weak self] newValue in
                guard let self = self else { return }
                let contentType = ImageContentType(rawValue: newValue) ?? .colorDocument
                self.imageContentType = contentType
            }
        case .imagesCount:
            numberOfRows = 1
            rowHeight = 50
            valueDidChangeHandler = { [weak self] newValue in
                guard let self = self else { return }
                self.numberOfCopies = newValue
            }
        case .posterShouldBe:
            numberOfRows = 1
            rowHeight = 50
            valueDidChangeHandler = { [weak self] newValue in
                guard let self = self else { return }
                self.pagesWide = newValue
            }
        case .preview:
            numberOfRows = 1
            rowHeight = 300
            valueDidChangeHandler = { _ in }
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
