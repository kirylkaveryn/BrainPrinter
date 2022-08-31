//
//  PrintingOptionsViewController.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import UIKit

class PrintingOptionsViewController: UITableViewController, PrintOptionsDelegate {
    private var presenter: PrintOptionsPresenterProtocol
    private var router: RouterProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Printing Options"
        
        setupTableView()
    }
    
    // MARK: - Setup methods
    init(presenter: PrintOptionsPresenterProtocol, router: RouterProtocol) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
        presenter.delegate = self
    }
   
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: ImageOrientationTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ImageOrientationTableViewCell.reusableID)
        tableView.register(UINib(nibName: ImagesPerPageTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ImagesPerPageTableViewCell.reusableID)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource[section].numberOfCells
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionContent = presenter.dataSource[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellReuseID, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.dataSource[section].sectionTitle
    }

}
