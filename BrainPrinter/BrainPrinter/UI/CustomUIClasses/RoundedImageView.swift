//
//  RoundedImageView.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import UIKit

class RoundedImageView: UIImageView {
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}
