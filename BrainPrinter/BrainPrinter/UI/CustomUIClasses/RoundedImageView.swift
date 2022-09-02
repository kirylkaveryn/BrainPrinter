//
//  RoundedImageView.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import UIKit

class RoundedImageView: UIView {
    
    private var imageView: UIImageView
    private let padding: CGFloat = 20
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        imageView = UIImageView()
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: "MainColor")!
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
