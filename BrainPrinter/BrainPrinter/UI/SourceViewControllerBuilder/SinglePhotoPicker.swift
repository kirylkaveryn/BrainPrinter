//
//  SinglePhotoPicker.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation
import UIKit

/// An object that build and configure UIImagePickerController.
///
/// To get view controller use make().
/// ```
/// let source = SinglePhotoPicker(dismissScreenCompletion: dismissScreenCompletion).make()
/// ```

class SinglePhotoPicker: NSObject, SourceProtocol {
    private var dismissScreenCompletion: DismissScreenCompletion
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(dismissScreenCompletion: @escaping DismissScreenCompletion) {
        self.dismissScreenCompletion = dismissScreenCompletion
    }
    
    func make() -> UIViewController {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = .photoLibrary
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.delegate = self
        return imagePickerViewController
    }
}

extension SinglePhotoPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = UIImage()
        if let possibleImage = info[.editedImage] as? UIImage {
            image = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            image = possibleImage
        }
        dismissScreenCompletion([image])
    }
}
