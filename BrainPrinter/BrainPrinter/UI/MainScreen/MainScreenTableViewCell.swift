//
//  MainScreenTableViewCell.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import UIKit

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
    
    // FIXME: magic number
    private func setupContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.cornerCurve = .continuous
        containerView.clipsToBounds = false
    }
        
    func setupWith(model: MainScreenColletionResourceProtocol) {
        title.text = model.title
        subtitle.text = model.subtitle
        supplementaryImage.image = model.image
        supplementaryImage.setRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        layer.backgroundColor = UIColor.clear.cgColor
//        if selected {
//            containerView.backgroundColor = .lightGray
//        } else {
//            containerView.backgroundColor = .white
//        }
        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
