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
    case posterShouldBe(pagesWide: Int = 1)
    case preview
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
        case .posterShouldBe:
            return "My poster shoild be..."
        case .preview:
            return "Preview"
        }
    }
}

/// This object provide set of About Information.
enum AboutInfo: CaseIterable {
    case description
    case instructions
    case printigRemainig
    case subscription
    case shareApp
    case sendFeedback
    case version
    case termsOfservice
    case privacyPolicy
}

extension AboutInfo {
    var title: String {
        switch self {
        case .description:
            return "Printer App - Smart Print Scan"
        case .instructions:
            return "Instructions"
        case .printigRemainig:
            return "Printings remainig"
        case .subscription:
            return "To manage your subscription"
        case .shareApp:
            return "Share Print App"
        case .sendFeedback:
            return "Send feedback"
        case .version:
            return "Version"
        case .termsOfservice:
            return "Terms of service"
        case .privacyPolicy:
            return "Privacy policy"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .description:
            return "Printer App allows you to print your photos and document easily."
        case .instructions:
            return "Make sure that your device and your printer are connected to the same Wi-Fi network."
        case .shareApp, .sendFeedback, .termsOfservice, .privacyPolicy:
            return nil
        case .printigRemainig:
            return "0/10"
        case .subscription:
            return "Some about how to subscribe..."
        case .version:
            return "1.0"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .description, .instructions, .printigRemainig, .subscription, .version:
            return nil
        case .shareApp:
            return UIImage(systemName: "square.and.arrow.up")!
        case .sendFeedback:
            return UIImage(systemName: "envelope")!
        case .termsOfservice:
            return UIImage(systemName: "doc.text")!
        case .privacyPolicy:
            return UIImage(systemName: "lock.shield.fill")!
        }
    }
    
    var url: URL? {
        switch self {
        case .description, .instructions, .printigRemainig, . subscription, . shareApp, .version:
            return nil
        case .sendFeedback:
            return URL(string: "lolkek@gmail.com")!
        case .termsOfservice:
            return URL(string: "https://www.termsfeed.com/live/873f6edc-82cb-44a7-a6a3-7ab7d17534d8")!
        case .privacyPolicy:
            return URL(string: "https://onhandapps.com/printer-app-privacy-policy/")!
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
    var sourceTypes: [SourceType] = SourceType.allCases
    var printOptions: [PrintOptions] = PrintOptions.allCases
}
