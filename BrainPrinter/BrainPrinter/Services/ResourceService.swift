//
//  ResourceService.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import Foundation
import UIKit

/// Type of sources which can be used to create a printing object.
enum SourceType: CaseIterable {
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

/// This object provide set of printing options.
///
/// Property `allCases` returns an array of all possible associated cases of image orientations, umages per count, content types and images count.
/// ```
/// let sourceTypes: [SourceType] = SourceType.allCases
/// ```
enum PrintOptions: CaseIterable {
    static var allCases: [PrintOptions] = [
        .imageOrientaion(ImageOrientation.allCases),
            .imagesPerPage(ImagesPerPageCount.allCases),
            .imageContentType(ImageContentType.allCases),
            .imagesCount]
    
    case imageOrientaion([ImageOrientation])
    case imagesPerPage([ImagesPerPageCount])
    case imageContentType([ImageContentType])
    case imagesCount
}

extension PrintOptions {
    var title: String {
        switch self {
        case .imageOrientaion:
            return "Portrait or Landscape"
        case .imagesPerPage:
            return "Images per page"
        case .imageContentType:
            return "Content type"
        case .imagesCount:
            return "Number of copies"
        }
    }
}

/// Protocol is used to create types that can be used as objects that encapsulate default settings for an application (images, titles, descriptions, etc.).
protocol ResourceServiceProtocol {
    var sourceTypes: [SourceType] { get }
    var printOptions: [PrintOptions] { get }
}

/// Object that encapsulate default settings for an application (images, titles, descriptions, etc.).
///
/// Properties `sourceTypes` and `printOptions` returns default setting with all possible cases of settings.
struct ResourceService: ResourceServiceProtocol {
    let sourceTypes: [SourceType] = SourceType.allCases
    let printOptions: [PrintOptions] = PrintOptions.allCases
}
