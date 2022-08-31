//
//  ResourceManager.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import Foundation
import UIKit

enum SourceType {
    case photo
    case document
    case scan
    case note
    case poster
}

protocol MainScreenItemContentProtocol {
    var image: UIImage { get }
    var title: String { get }
    var subtitle: String { get }
    var sourceType: SourceType { get }
}

protocol PrintOptionsSectionContentProtocol {
    var sectionTitle: String { get }
    var cellReuseID: String { get }
    var nibName: String? { get }
    var numberOfCells: Int { get }
    var rowHeight: Int { get }
    var info: [String : String]? { get }
}

protocol ResourceManagerProtocol {
    var mainScreenCollectionDataSource: [MainScreenItemContentProtocol] { get set }
    var printingOptionsDataSource: [PrintOptionsSectionContentProtocol] { get set }
}

struct MainScreenItemContentModel: MainScreenItemContentProtocol {
    let image: UIImage
    let title: String
    let subtitle: String
    let sourceType: SourceType
}

struct PrintingOptionsSectionContentModel: PrintOptionsSectionContentProtocol {
    var sectionTitle: String
    var cellReuseID: String
    var nibName: String?
    var numberOfCells: Int
    var rowHeight: Int
    var info: [String : String]?
}

struct ResourceManager: ResourceManagerProtocol {
    
    var mainScreenCollectionDataSource: [MainScreenItemContentProtocol] = [
        MainScreenItemContentModel(image: UIImage(systemName: "photo.on.rectangle")!,
                                    title: "Print Photos",
                                    subtitle: "Import photos and print them",
                                    sourceType: .photo),
        MainScreenItemContentModel(image: UIImage(systemName: "folder")!,
                                    title: "Print Documents",
                                    subtitle: "Print documents from your files or iCloud",
                                    sourceType: .document),
        MainScreenItemContentModel(image: UIImage(systemName: "scanner")!,
                                    title: "Scan",
                                    subtitle: "Use your camera to scan then print",
                                    sourceType: .scan),
        MainScreenItemContentModel(image: UIImage(systemName: "note.text")!,
                                    title: "Print Notes",
                                    subtitle: "Past or type any text to print",
                                    sourceType: .note),
        MainScreenItemContentModel(image: UIImage(systemName: "photo")!,
                                    title: "Print Large Poster",
                                    subtitle: "Split an image into multiple pages",
                                    sourceType: .poster),
    ]
    
    var printingOptionsDataSource: [PrintOptionsSectionContentProtocol] = [
        PrintingOptionsSectionContentModel(sectionTitle: "Portrait or Landscape",
                                           cellReuseID: ImageOrientationTableViewCell.reusableID,
                                           nibName: ImageOrientationTableViewCell.nibName,
                                           numberOfCells: 1,
                                           rowHeight: 100),
        PrintingOptionsSectionContentModel(sectionTitle: "Images per page",
                                           cellReuseID: ImagesPerPageTableViewCell.reusableID,
                                           nibName: ImagesPerPageTableViewCell.nibName,
                                           numberOfCells: 1,
                                           rowHeight: 100),
    ]

    
}

//let data = [
//    PrintingOptionsModel(sectionTitle: "Portrait or Landscape", cellInfo: [:]),
//    PrintingOptionsModel(sectionTitle: "Images per page", cellInfo: [:]),
//    PrintingOptionsModel(sectionTitle: "Content type", cellInfo: [:]),
//    PrintingOptionsModel(sectionTitle: "Number of copies", cellInfo: [:])
//    ]
