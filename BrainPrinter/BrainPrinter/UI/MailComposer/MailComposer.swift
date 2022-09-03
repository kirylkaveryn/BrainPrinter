//
//  MailComposer.swift
//  BrainPrinter
//
//  Created by Kirill on 3.09.22.
//

import Foundation
import MessageUI

class MailComposer: NSObject, MFMailComposeViewControllerDelegate {
    
    private let recipient: URL?
    private var message: String?

    init(recipient: URL?, message: String?) {
        self.recipient = recipient
    }
    
    func make() -> UIViewController? {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipient?.path ?? ""])
            mail.setMessageBody(message ?? "", isHTML: true)
            return mail
        } else {
            return nil
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
