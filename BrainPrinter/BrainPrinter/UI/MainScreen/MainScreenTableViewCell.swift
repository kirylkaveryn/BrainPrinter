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
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var supplementaryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
