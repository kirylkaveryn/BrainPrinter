//
//  NotePresenter.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation

protocol NotePresenterProtocol: AnyObject {
    func sendToPrinter(text: String)
}

class NotePresenter: NotePresenterProtocol {
    private let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }
    
    
    func sendToPrinter(text: String) {
        router.sendToPrinter(text: text)
    }
    
    
}
