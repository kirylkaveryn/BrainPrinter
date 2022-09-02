//
//  PosterPreviewTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 2.09.22.
//

import UIKit

class PosterPreviewTableViewCell: UITableViewCell {
    
    static let reusableID = "PosterPreviewTableViewCell"
    static let nibName = reusableID
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupView() {
        imagePreview.contentMode = .scaleAspectFit
    }
    
    
}
