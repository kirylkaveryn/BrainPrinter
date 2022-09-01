//
//  PrintOptionsSectionContentModel.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation

protocol PrintOptionsSectionContentProtocol {
    var sectionTitle: String { get }
    var printOptions: PrintOptions { get }
    var numberOfRows: Int { get }
}

struct PrintOptionsSectionContentModel: PrintOptionsSectionContentProtocol {
    var sectionTitle: String
    var printOptions: PrintOptions
    var numberOfRows: Int
    var rowHeight: Int
    var valueDidChangeHandler: ((Int) -> ())?
}
