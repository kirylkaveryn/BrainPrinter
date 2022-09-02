//
//  SourceViewController.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import Foundation
import UIKit

typealias DismissScreenCompletion = ([UIImage]) -> Void

/// Protocol for sources of data for printing.
protocol SourceProtocol: AnyObject {
    init(dismissScreenCompletion: @escaping DismissScreenCompletion)
    func make() -> UIViewController
}

