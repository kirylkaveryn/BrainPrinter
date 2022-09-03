//
//  AboutInfoTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 3.09.22.
//

import UIKit

class AboutInfoTableViewCell: UITableViewCell {

    static let reusableID = "AboutInfoTableViewCell"
    static let nibName = reusableID
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String, subtitle: String?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}
