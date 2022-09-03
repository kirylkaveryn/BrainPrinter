//
//  AboutButtonTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 3.09.22.
//

import UIKit

class AboutButtonTableViewCell: UITableViewCell {

    static let reusableID = "AboutButtonTableViewCell"
    static let nibName = reusableID
    private var valueDidChangeHandler: (() -> ())?

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    
    func configure(title: String, image: UIImage?, valueDidChangeHandler: (() -> ())?) {
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        self.valueDidChangeHandler = valueDidChangeHandler
    }
    
    @objc private func buttonDidTap() {
        valueDidChangeHandler?()
    }
    
}
