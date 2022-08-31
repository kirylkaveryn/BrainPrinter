//
//  ImageOrientationTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import UIKit

class ImageOrientationTableViewCell: UITableViewCell {

    static let reusableID = "ImageOrientationTableViewCell"
    static let nibName = reusableID
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        segmentControl.removeAllSegments()
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(handleSegmentSwitch), for: .valueChanged)
    }
    
    func configureCell(orientations: [ImageOrientation] = ImageOrientation.allCases) {
        for (index, orientation) in orientations.enumerated() {
            let image = orientation.image.scalePreservingAspectRatio(targetSize: CGSize(width: 50, height: 50))
            segmentControl.insertSegment(with: image, at: index, animated: false)
        }
        segmentControl.selectedSegmentIndex = 0
    }
    
    @objc private func handleSegmentSwitch() {
        guard let selectedIndex = ImageOrientation.init(rawValue: segmentControl.selectedSegmentIndex) else { return }
        NotificationCenter.default.post(
            name: kPrintingOptionOrientaionNotification,
            object: self,
            userInfo: [ kPrintingOptionOrientaionKey : selectedIndex])
    }
}
