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

/// Object is used to provide data source for and handle iteractions with NoteViewControler.
class NotePresenter: NotePresenterProtocol {
    private let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }
    
    func sendToPrinter(text: String) {
        let printingText = PrintingText(text: text)
        router.sendToPrinter(.text(printingText))
    }
}
