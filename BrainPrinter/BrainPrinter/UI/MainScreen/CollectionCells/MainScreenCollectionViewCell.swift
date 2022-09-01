//
//  MainScreenTableViewCell.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {
    
    static let reusableID = "MainScreenCollectionViewCell"
    static let nibName = reusableID
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var supplementaryImage: RoundedImageView!
    
    var cellDidPress: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContentView()
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = false
    }
        
    func configure(model: MainScreenCellViewModel?) {
        title.text = model?.title
        subtitle.text = model?.subtitle
        supplementaryImage.image = model?.image
        cellDidPress = model?.cellDidPress
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                cellDidPress?()
            }
        }
    }
}
