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
    private var valueDidChangeHandler: ((Int) -> Void)?
    
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
    
    func configureCell(orientations: [ImageOrientation] = ImageOrientation.allCases, selected: ImageOrientation, valueDidChangeHandler: ((Int) -> Void)?) {
        self.valueDidChangeHandler = valueDidChangeHandler
        for (index, orientation) in orientations.enumerated() {
            let image = orientation.image.scalePreservingAspectRatio(targetSize: CGSize(width: 50, height: 50))
            segmentControl.insertSegment(with: image, at: index, animated: false)
        }
        segmentControl.selectedSegmentIndex = selected.rawValue
    }
    
    @objc private func handleSegmentSwitch() {
        valueDidChangeHandler?(segmentControl.selectedSegmentIndex)
    }
}
