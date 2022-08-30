//
//  MainScreenSectionHeader.swift
//  BrainPrinter
//
//  Created by Kirill on 30.08.22.
//

import UIKit

class MainScreenSectionHeader: UICollectionReusableView {

    static let reusableID = "MainScreenSectionHeader"
    static let nibName = "MainScreenSectionHeader"
    
    @IBOutlet weak var headerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
