//
//  NoteViewController.swift
//  BrainPrinter
//
//  Created by Kirill on 1.09.22.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    private var presenter: NotePresenter
    
    init(presenter: NotePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
   
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print", style: .plain, target: self, action: #selector(printButtonDidTap))
    }
    
    @objc func printButtonDidTap() {
        presenter.sendToPrinter(text: textView.text)
    }
    
}
