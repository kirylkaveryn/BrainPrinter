//
//  ImagesCountTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import UIKit

class ImagesCountTableViewCell: UITableViewCell {

    static let reusableID = "ImagesCountTableViewCell"
    static let nibName = reusableID
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        stepperDidStep()
    }
    
    private func setupView() {
        selectionStyle = .none
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(stepperDidStep), for: .valueChanged)
    }
    
    @objc private func stepperDidStep() {
        label.text = "Print copies: \((Int)(stepper.value))"
    }
    
}
