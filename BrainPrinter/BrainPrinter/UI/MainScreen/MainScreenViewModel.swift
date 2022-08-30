//
//  MainScreenViewModel.swift
//  BrainPrinter
//
//  Created by Kiryl Kaveryn on 29.08.22.
//

import Foundation

protocol MainScreenViewModelProtocol {
    var delegate: MainScreenDelegate? { get }
    // FIXME: испарить на модель
    var dataSource: [String] { get }
}

protocol MainScreenDelegate: AnyObject {
    func updateView()
}

class MainScreenViewModel: MainScreenViewModelProtocol {
    let dataSource = ["Print Photos", "Print Documents", "Scan", "Print Notes"]
    weak var delegate: MainScreenDelegate?
    
    init(delegate: MainScreenDelegate) {
        self.delegate = delegate
    }
}
