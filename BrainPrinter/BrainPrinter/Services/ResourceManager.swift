//
//  ResourceManager.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import Foundation
import UIKit

enum ResourceType {
    case photo
    case document
    case scan
    case note
    case poster
}

protocol MainScreenColletionResourceProtocol {
    var image: UIImage { get }
    var title: String { get }
    var subtitle: String { get }
    var resourceType: ResourceType { get }
}

protocol ResourceManagerProtocol {
    var mainScreenCollectionDataSource: [MainScreenColletionResourceProtocol] { get set }
}

struct MainScreenColletionResource: MainScreenColletionResourceProtocol {
    let image: UIImage
    let title: String
    let subtitle: String
    let resourceType: ResourceType
}

class ResourceManager: ResourceManagerProtocol {
    var mainScreenCollectionDataSource: [MainScreenColletionResourceProtocol] = [
        MainScreenColletionResource(image: UIImage(systemName: "photo.on.rectangle")!,
                                    title: "Print Photos",
                                    subtitle: "Import photos and print them",
                                    resourceType: .photo),
        MainScreenColletionResource(image: UIImage(systemName: "folder")!,
                                    title: "Print Documents",
                                    subtitle: "Print documents from your files or iCloud",
                                    resourceType: .document),
        MainScreenColletionResource(image: UIImage(systemName: "scanner")!,
                                    title: "Scan",
                                    subtitle: "Use your camera to scan then print",
                                    resourceType: .scan),
        MainScreenColletionResource(image: UIImage(systemName: "note.text")!,
                                    title: "Print Notes",
                                    subtitle: "Past or type any text to print",
                                    resourceType: .note),
        MainScreenColletionResource(image: UIImage(systemName: "photo")!,
                                    title: "Print Large Poster",
                                    subtitle: "Split an image into multiple pages",
                                    resourceType: .poster),
    ]
    
}
