//
//  AboutScreenPresenter.swift
//  BrainPrinter
//
//  Created by Kirill on 3.09.22.
//

import Foundation
import UIKit

struct AboutContentModel {
    var aboutInfo: AboutInfo
    var valueDidChangeHandler: (() -> ())?
}

protocol AboutScreenPresenterProtocol: AnyObject {
    var dataSource: [AboutContentModel] { get }
}

class AboutScreenPresenter: AboutScreenPresenterProtocol {
    private let router: RouterProtocol
    private(set) var dataSource: [AboutContentModel] = []

    init(router: RouterProtocol, aboutInfo: [AboutInfo] = AboutInfo.allCases) {
        self.router = router
        self.dataSource = aboutInfo.map { parseToModel($0) }
    }
    
    private func parseToModel(_ option: AboutInfo) -> AboutContentModel {
        var valueDidChangeHandler: (() -> ())?
        switch option {
        case .shareApp:
            valueDidChangeHandler = { [weak self] in
                
            }
        case .sendFeedback:
            valueDidChangeHandler = { [weak self] in
                guard let self = self else { return }
                self.router.sendFeedback(recipient: option.url, message: nil)
            }
        case .termsOfservice:
            valueDidChangeHandler = { [weak self] in
                guard let self = self else { return }
                self.router.openURL(url: option.url)
            }
        case .privacyPolicy:
            valueDidChangeHandler = { [weak self] in
                guard let self = self else { return }
                self.router.openURL(url: option.url)
            }
        case .description, .instructions, .printigRemainig, .version, .subscription:
            valueDidChangeHandler = nil
        }
        
        return AboutContentModel(aboutInfo: option,
                                 valueDidChangeHandler: valueDidChangeHandler)
    }
    
}

