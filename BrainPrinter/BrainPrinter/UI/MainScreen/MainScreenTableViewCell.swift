//
//  MainScreenTableViewCell.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import UIKit

struct MainScreenTableViewCellViewModel {
    var image: UIImage
    var title: String
    var subtitle: String
}

class MainScreenTableViewCell: UITableViewCell {
    
    static let reusableID = "MainScreenTableViewCell"
    static let nibName = "MainScreenTableViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var supplementaryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerView()
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.cornerCurve = .continuous
        containerView.clipsToBounds = false
    }
        
    func setupWith(model: MainScreenTableViewCellViewModel) {
        title.text = model.title
        subtitle.text = model.subtitle
        supplementaryImage.image = model.image
        supplementaryImage.setRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
