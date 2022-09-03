//
//  AboutScreenViewController.swift
//  BrainPrinter
//
//  Created by Kirill on 3.09.22.
//

import UIKit

class AboutScreenViewController: UITableViewController {

    private var presenter: AboutScreenPresenterProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About Printer"
        setupTableView()
        setupNavigationBar()
    }
    
    init(presenter: AboutScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
   
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonDidTap))
    }
    
    private func setupTableView() {
        tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: AboutInfoTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AboutInfoTableViewCell.reusableID)
        tableView.register(UINib(nibName: AboutButtonTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AboutButtonTableViewCell.reusableID)
        tableView.register(AboutPlainTableViewCell.self, forCellReuseIdentifier: AboutPlainTableViewCell.reusableID)
    }

    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = presenter.dataSource[indexPath.section].aboutInfo
        let valueDidChangeHandler = presenter.dataSource[indexPath.section].valueDidChangeHandler
        
        switch info {
        case .description, .instructions, .subscription:
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutInfoTableViewCell.reusableID, for: indexPath) as! AboutInfoTableViewCell
            cell.configure(title: info.title, subtitle: info.subtitle)
            return cell

        case .printigRemainig, .version:
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutPlainTableViewCell.reusableID, for: indexPath)
            cell.textLabel?.text = info.title
            cell.detailTextLabel?.text = info.subtitle
            return cell

        case .shareApp, .sendFeedback, .termsOfservice, .privacyPolicy:
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutButtonTableViewCell.reusableID, for: indexPath) as! AboutButtonTableViewCell
            cell.configure(title: info.title, image: info.image, valueDidChangeHandler: valueDidChangeHandler)
            return cell
        }
    }
}

extension AboutScreenViewController {
    @objc private func doneButtonDidTap() {
        dismiss(animated: true)
    }
}
