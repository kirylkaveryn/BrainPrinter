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
    
    @IBOutlet weak var orientationSegmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCell() {
        orientationSegmentControl.removeAllSegments()
        orientationSegmentControl.selectedSegmentTintColor = .systemBlue
        for (index, orientation) in ImageOrientation.allCases.enumerated() {
            orientationSegmentControl.insertSegment(with: orientation.image, at: index, animated: false)
        }
        orientationSegmentControl.selectedSegmentIndex = 0

    }
}
