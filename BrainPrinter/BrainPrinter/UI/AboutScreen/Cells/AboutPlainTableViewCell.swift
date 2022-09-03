//
//  AboutPlainTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 3.09.22.
//

import UIKit

class AboutPlainTableViewCell: UITableViewCell {
    
    static let reusableID = "AboutPlainTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
