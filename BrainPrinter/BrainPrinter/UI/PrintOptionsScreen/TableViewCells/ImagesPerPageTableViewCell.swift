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
    
    @IBOutlet weak var imagesPerPageSegmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCell() {
        imagesPerPageSegmentControl.removeAllSegments()
        imagesPerPageSegmentControl.selectedSegmentTintColor = .systemBlue
        for (index, imagesCountCase) in ImagesPerPageCount.allCases.enumerated() {
            imagesPerPageSegmentControl.insertSegment(with: imagesCountCase.image, at: index, animated: false)
        }
        imagesPerPageSegmentControl.selectedSegmentIndex = 0
    }
    
}
