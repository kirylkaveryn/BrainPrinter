//
//  MainScreenTableViewCell.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {
    
    static let reusableID = "MainScreenCollectionViewCell"
    static let nibName = "MainScreenCollectionViewCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var supplementaryImage: RoundedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContentView()
    }
    
    // FIXME: magic number
    private func setupContentView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = false
    }
        
    func configure(model: MainScreenResourceProtocol) {
        title.text = model.title
        subtitle.text = model.subtitle
        supplementaryImage.image = model.image
    }

}
