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
        setupView()
    }
    
    private func setupView() {
        segmentControl.removeAllSegments()
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(handleSegmentSwitch), for: .valueChanged)
    }

    func configureCell(countCases: [ImagesPerPageCount] = ImagesPerPageCount.allCases) {
        for (index, imagesCountCase) in countCases.enumerated() {
            let image = imagesCountCase.image.scalePreservingAspectRatio(targetSize: CGSize(width: 50, height: 50))
            segmentControl.insertSegment(with: image, at: index, animated: false)
        }
        segmentControl.selectedSegmentIndex = 0

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
