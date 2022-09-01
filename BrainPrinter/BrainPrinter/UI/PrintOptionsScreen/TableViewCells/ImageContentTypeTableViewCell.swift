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
    private var contentType: ImageContentType?
    private var valueDidChangeHandler: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(contentType: ImageContentType, valueDidChangeHandler: ((Int) -> Void)?) {
        self.contentType = contentType
        self.valueDidChangeHandler = valueDidChangeHandler
        textLabel?.text = contentType.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            accessoryType = .checkmark
            guard let contentType = contentType else {
                return
            }
            valueDidChangeHandler?(contentType.rawValue)
        } else {
            accessoryType = .none
        }
    }
}
