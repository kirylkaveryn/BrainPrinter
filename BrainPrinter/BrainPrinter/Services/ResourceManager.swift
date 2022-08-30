//
//  ResourceManager.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import Foundation
import UIKit

protocol MainScreenColletionResourceProtocol {
    var image: UIImage { get set }
    var title: String { get set }
    var subtitle: String { get set }
}

protocol ResourceManagerProtocol {
    var mainScreenCollectionDataSource: [MainScreenColletionResourceProtocol] { get set }
}

struct MainScreenColletionResource: MainScreenColletionResourceProtocol {
    var image: UIImage
    var title: String
    var subtitle: String
}

class ResourceManager: ResourceManagerProtocol {
    var mainScreenCollectionDataSource: [MainScreenColletionResourceProtocol] = [
        MainScreenColletionResource(image: UIImage(systemName: "person")!, title: "Print Photos", subtitle: "Import photos and print them"),
        MainScreenColletionResource(image: UIImage(systemName: "safari")!, title: "Print Documents", subtitle: "Print documents from your files or iCloud"),
        MainScreenColletionResource(image: UIImage(systemName: "person")!, title: "Scan", subtitle: "Use your camera to scan then print"),
        MainScreenColletionResource(image: UIImage(systemName: "safari")!, title: "Print Notes", subtitle: "Past or type any text to print"),
        MainScreenColletionResource(image: UIImage(systemName: "person")!, title: "Print Large Poster", subtitle: "Split an image into multiple pages"),
    ]
    
    
}
