//
//  Router.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import Foundation
import UIKit
import PhotosUI
import VisionKit

protocol RouterProtocol {
    init(navigationController: UINavigationController)
    
    func goTo(resource: ResourceType, completion: @escaping ([UIImage]) -> Void)
}

class Router: NSObject, RouterProtocol {
    private let navigationController: UINavigationController
    private var resultResource: [UIImage] = []
    private var completion: (([UIImage]) -> Void)?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goTo(resource: ResourceType, completion: @escaping ([UIImage]) -> Void) {
        self.completion = completion
        switch resource {
        case .photo:
            var configuration = PHPickerConfiguration()
            configuration.filter = .images
            configuration.selectionLimit = 0
            let phtotosPickerViewController = PHPickerViewController(configuration: configuration)
            phtotosPickerViewController.delegate = self
            navigationController.present(phtotosPickerViewController, animated: true)

        case .document:
            break
        case .scan:
            let scannerViewController = VNDocumentCameraViewController()
            scannerViewController.delegate = self
            navigationController.present(scannerViewController, animated: true)
        case .note:
            break
        case .poster:
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.delegate = self
            navigationController.present(imagePickerViewController, animated: true)
        }
    }
    
    private func cleanUpResultResource() {
        resultResource = []
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension Router: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = UIImage()
        
        if let possibleImage = info[.editedImage] as? UIImage {
            image = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            image = possibleImage
        }

        resultResource = [image]
        navigationController.dismiss(animated: true)
        if let completion = completion {
            completion(resultResource)
        }
        self.cleanUpResultResource()
    }
}

// MARK: - PHPickerViewControllerDelegate

extension Router: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let uploadGroup = DispatchGroup()
        if !results.isEmpty {
            for result in results {
                uploadGroup.enter()
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let self = self else { return }
                        if let image = image as? UIImage {
                            self.resultResource.append(image)
                        }
                        uploadGroup.leave()
                    }
                }
            }
        }
        uploadGroup.notify(queue: .main) {
            self.navigationController.dismiss(animated: true)
            if let completion = self.completion {
                completion(self.resultResource)
            }
            self.cleanUpResultResource()
        }
    }
}

// MARK: - VNDocumentCameraViewControllerDelegate

extension Router: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageNumber in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            resultResource.append(image)
        }
        if let completion = completion {
            completion(resultResource)
        }
        navigationController.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        navigationController.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        navigationController.dismiss(animated: true)
    }
}
