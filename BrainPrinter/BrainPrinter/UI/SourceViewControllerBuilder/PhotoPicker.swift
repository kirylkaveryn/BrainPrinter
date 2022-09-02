//
//  PhotoPicker.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation
import UIKit
import PhotosUI

/// An object that build and configure PHPickerViewController.
///
/// To get view controller use make().
/// ```
/// let source = PhotoPicker(dismissScreenCompletion: dismissScreenCompletion).make()
/// ```

class PhotoPicker: SourceProtocol {
    private var dismissScreenCompletion: DismissScreenCompletion
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(dismissScreenCompletion: @escaping DismissScreenCompletion) {
        self.dismissScreenCompletion = dismissScreenCompletion
    }
    
    func make() -> UIViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0
        let photosPickerViewController = PHPickerViewController(configuration: configuration)
        photosPickerViewController.delegate = self
        return photosPickerViewController
    }
}

extension PhotoPicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        var images: [UIImage] = []
        let uploadGroup = DispatchGroup()
        if !results.isEmpty {
            for result in results {
                uploadGroup.enter()
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        if let image = image as? UIImage {
                            images.append(image)
                        }
                        uploadGroup.leave()
                    }
                }
            }
        }
        uploadGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                if !images.isEmpty {
                    self.dismissScreenCompletion(images)
                } else {
                    picker.dismiss(animated: true)
                }
            }
        }
    }
    
}
