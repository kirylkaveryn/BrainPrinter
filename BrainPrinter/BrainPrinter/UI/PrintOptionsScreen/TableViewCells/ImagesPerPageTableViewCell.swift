//
//  ImagesPerPageTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import UIKit

class ImagesPerPageTableViewCell: UITableViewCell {

    static let reusableID = "ImagesPerPageTableViewCell"
    static let nibName = reusableID
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCell() {
        segmentControl.removeAllSegments()
        segmentControl.selectedSegmentTintColor = .systemBlue
        for (index, imagesCountCase) in ImagesPerPageCount.allCases.enumerated() {
            let image = imagesCountCase.image.scalePreservingAspectRatio(targetSize: CGSize(width: 50, height: 50))
            segmentControl.insertSegment(with: image, at: index, animated: false)
        }
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(handleSegmentSwitch), for: .valueChanged)
    }
    
    @objc private func handleSegmentSwitch() {
        guard let selectedIndex = ImagesPerPageCount.init(rawValue: segmentControl.selectedSegmentIndex) else { return }
        NotificationCenter.default.post(
            name: kPrintingOptionOrientaionNotification,
            object: self,
            userInfo: [ kPrintingOptionImagesPerPageKey : selectedIndex])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(segmentControl.widthForSegment(at: 0))
    }
    
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

