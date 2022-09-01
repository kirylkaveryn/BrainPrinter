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

extension SourceType {
    var image: UIImage {
        switch self {
        case .photo:
            return UIImage(systemName: "photo.on.rectangle")!
        case .document:
            return UIImage(systemName: "folder")!
        case .scan:
            return UIImage(systemName: "scanner")!
        case .note:
            return UIImage(systemName: "note.text")!
        case .poster:
            return UIImage(systemName: "photo")!
        }
    }
    
    var content: (title: String, subtitle: String) {
        switch self {
        case .photo:
            return (title: "Print Photos", subtitle: "Import photos and print them")
        case .document:
            return (title: "Print Documents", subtitle: "Print documents from your files or iCloud")
        case .scan:
            return (title: "Scan", subtitle: "Use your camera to scan then print")
        case .note:
            return (title: "Print Notes", subtitle: "Past or type any text to print")
        case .poster:
            return (title: "Print Large Poster", subtitle: "Split an image into multiple pages")
        }
    }
}

protocol MainScreenItemContentProtocol {
    var image: UIImage { get }
    var title: String { get }
    var subtitle: String { get }
    var sourceType: SourceType { get }
}

protocol PrintOptionsSectionContentProtocol {
    var sectionTitle: String { get }
    var cellType: CellType { get }
    var numberOfCells: Int { get }
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

struct PrintOptionsSectionContentModel: PrintOptionsSectionContentProtocol {
    var sectionTitle: String
    var cellType: CellType
    var numberOfCells: Int
    var info: [String : String]?
}

enum CellType {
    case imageOrientaion, imagesPerPage, imageContentType, imagesCount
    
    var cellReuseID: String {
        switch self {
        case .imageOrientaion:
            return ImageOrientationTableViewCell.reusableID
        case .imagesPerPage:
            return ImagesPerPageTableViewCell.reusableID
        case .imageContentType:
            return ImageContentTypeTableViewCell.reusableID
        case .imagesCount:
            return ImagesCountTableViewCell.reusableID
        }
    }
    
    var nibName: String {
        switch self {
        case .imageOrientaion:
            return ImageOrientationTableViewCell.nibName
        case .imagesPerPage:
            return ImagesPerPageTableViewCell.nibName
        case .imageContentType:
            return ImageContentTypeTableViewCell.nibName
        case .imagesCount:
            return ImagesCountTableViewCell.nibName
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .imageOrientaion:
            return 100
        case .imagesPerPage:
            return 100
        case .imageContentType:
            return 50
        case .imagesCount:
            return 50
        }
    }
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
        PrintOptionsSectionContentModel(sectionTitle: "Portrait or Landscape",
                                           cellType: .imageOrientaion,
                                           numberOfCells: 1),
        PrintOptionsSectionContentModel(sectionTitle: "Images per page",
                                           cellType: .imagesPerPage,
                                           numberOfCells: 1),
        PrintOptionsSectionContentModel(sectionTitle: "Content type",
                                           cellType: .imageContentType,
                                           numberOfCells: ImageContentType.allCases.count),
//        PrintOptionsSectionContentModel(sectionTitle: "Number of copies",
//                                           cellType: .imagesCount,
//                                           numberOfCells: 1),
    ]
}
