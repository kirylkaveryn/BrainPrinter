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
        tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        for section in presenter.dataSource {
            let nibName = section.cellType.nibName
            tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: section.cellType.cellReuseID)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.dataSource[section].numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(presenter.dataSource[indexPath.section].rowHeight)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionContent = presenter.dataSource[indexPath.section]
//        let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellReuseID, for: indexPath)
        switch sectionContent.cellType {
        case .imageOrientaion:
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellType.cellReuseID, for: indexPath) as! ImageOrientationTableViewCell
            cell.configureCell()
            return cell
        case .imagesPerPage:
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellType.cellReuseID, for: indexPath) as! ImagesPerPageTableViewCell
            cell.configureCell()
            return cell
        case .imageContentType:
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellType.cellReuseID, for: indexPath) as! ImageContentTypeTableViewCell
            cell.configureCell(contentType: ImageContentType(rawValue: indexPath.row)!)
            return cell
        case .imagesCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellType.cellReuseID, for: indexPath) as! ImageOrientationTableViewCell // FIXME:
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.dataSource[section].sectionTitle
    }

}
