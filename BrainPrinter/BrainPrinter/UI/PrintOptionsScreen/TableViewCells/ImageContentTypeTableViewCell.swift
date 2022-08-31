//
//  ImageContentTypeTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import UIKit

class ImageContentTypeTableViewCell: UITableViewCell {

    static let reusableID = "ImageContentTypeTableViewCell"
    static let nibName = reusableID
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(contentType: ImageContentType) {
        textLabel?.text = contentType.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        isSelected ? (accessoryType = .checkmark) : (accessoryType = .none)
    }
    
}
