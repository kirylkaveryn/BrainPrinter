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

protocol MainScreenResourceProtocol {
    var image: UIImage { get }
    var title: String { get }
    var subtitle: String { get }
    var sourceType: SourceType { get }
}

protocol PrintOptionsResourceProtocol {
    var sectionTitle: String { get }
    var cellInfo: [String : String] { get }
}

protocol ResourceManagerProtocol {
    var mainScreenCollectionDataSource: [MainScreenResourceProtocol] { get set }
}

struct MainScreenResource: MainScreenResourceProtocol {
    let image: UIImage
    let title: String
    let subtitle: String
    let sourceType: SourceType
}

class ResourceManager: ResourceManagerProtocol {
    var mainScreenCollectionDataSource: [MainScreenResourceProtocol] = [
        MainScreenResource(image: UIImage(systemName: "photo.on.rectangle")!,
                                    title: "Print Photos",
                                    subtitle: "Import photos and print them",
                                    sourceType: .photo),
        MainScreenResource(image: UIImage(systemName: "folder")!,
                                    title: "Print Documents",
                                    subtitle: "Print documents from your files or iCloud",
                                    sourceType: .document),
        MainScreenResource(image: UIImage(systemName: "scanner")!,
                                    title: "Scan",
                                    subtitle: "Use your camera to scan then print",
                                    sourceType: .scan),
        MainScreenResource(image: UIImage(systemName: "note.text")!,
                                    title: "Print Notes",
                                    subtitle: "Past or type any text to print",
                                    sourceType: .note),
        MainScreenResource(image: UIImage(systemName: "photo")!,
                                    title: "Print Large Poster",
                                    subtitle: "Split an image into multiple pages",
                                    sourceType: .poster),
    ]
    
}
