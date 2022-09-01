//
//  RoundedImageView.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import UIKit

class RoundedImageView: UIImageView {
    
    private let padding: CGFloat = -10
    // FIXME: - добавть новыый слой для картинки
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override var image: UIImage? {
        get {
            super.image
        }
        set {
            super.image = newValue?.withAlignmentRectInsets(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
    }
}
