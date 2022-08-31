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

    func configureCell(countCases: [ImagesPerPageCount] = ImagesPerPageCount.allCases, valueDidChangeHandler: ((Int) -> Void)?) {
        self.valueDidChangeHandler = valueDidChangeHandler
        for (index, imagesCountCase) in countCases.enumerated() {
            let image = imagesCountCase.image.scalePreservingAspectRatio(targetSize: CGSize(width: 50, height: 50))
            segmentControl.insertSegment(with: image, at: index, animated: false)
        }
        segmentControl.selectedSegmentIndex = 0
    }
    
    @objc private func handleSegmentSwitch() {
        valueDidChangeHandler?(segmentControl.selectedSegmentIndex)
    }
    
}
