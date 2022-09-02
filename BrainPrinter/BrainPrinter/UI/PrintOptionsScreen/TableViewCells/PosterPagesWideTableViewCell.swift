//
//  PosterPagesWideTableViewCell.swift
//  BrainPrinter
//
//  Created by Kirill on 2.09.22.
//

import UIKit

class PosterPagesWideTableViewCell: UITableViewCell {

    static let reusableID = "PosterPagesWideTableViewCell"
    static let nibName = reusableID
    private var valueDidChangeHandler: ((Int) -> Void)?
    
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
        stepper.maximumValue = 4
        stepper.addTarget(self, action: #selector(stepperDidStep), for: .valueChanged)
    }
    
    func configureCell(selected: Double, valueDidChangeHandler: ((Int) -> Void)?) {
        self.valueDidChangeHandler = valueDidChangeHandler
        stepper.value = selected
    }
    
    @objc private func stepperDidStep() {
        let value = (Int)(stepper.value)
        label.text = "\(value) pages wide"
        valueDidChangeHandler?(value)
    }
    
}
