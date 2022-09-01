//
//  PrintOptionsViewController.swift
//  BrainPrinter
//
//  Created by Kirill on 31.08.22.
//

import UIKit

class PrintOptionsViewController: UITableViewController {
    private var presenter: PrintOptionsPresenterProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Print Options"
        setupTableView()
        setupNavigationBar()
    }
    
    init(presenter: PrintOptionsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
   
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print", style: .plain, target: self, action: #selector(printButtonDidTap))
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
        presenter.dataSource[indexPath.section].cellType.cellHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionContent = presenter.dataSource[indexPath.section]

        // расшиить енам функцией update. Ввести протоколы и вложить внутрить доп енамы
        // . Протокол для PrintItem
        // создать маппер для преобразований (конверт)
        switch sectionContent.cellType {
        case .imageOrientaion:
            // FIXME: - убрать sectionContent.cellType.cellReuseID и написать ImageOrientationTableViewCell.reuseID
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellType.cellReuseID, for: indexPath) as! ImageOrientationTableViewCell
            let selectedCase = presenter.printingItem.imageOrientation
            cell.configureCell(selected: selectedCase, valueDidChangeHandler: { [weak self] newValue in
                guard let self = self else { return }
                guard let orientation = ImageOrientation(rawValue: newValue) else { return }
                self.presenter.printingItem.imageOrientation = orientation
            })
            return cell
        
        case .imagesPerPage:
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellType.cellReuseID, for: indexPath) as! ImagesPerPageTableViewCell
            let selectedCase = presenter.printingItem.imagesPerPageCount
            cell.configureCell(selected: selectedCase, valueDidChangeHandler: { [weak self] newValue in
                guard let self = self else { return }
                guard let imagesPerPage = ImagesPerPageCount(rawValue: newValue) else { return }
                self.presenter.printingItem.imagesPerPageCount = imagesPerPage
            })
            return cell
        
        case .imageContentType:
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellType.cellReuseID, for: indexPath) as! ImageContentTypeTableViewCell
            let contentType = ImageContentType.allCases[indexPath.row]
            cell.configureCell(contentType: contentType, valueDidChangeHandler: { [weak self]  contentType in
                guard let self = self else { return }
                self.presenter.printingItem.imageContentType = contentType
            })
            if contentType == presenter.printingItem.imageContentType {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
            return cell
        
        case .imagesCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionContent.cellType.cellReuseID, for: indexPath) as! ImagesCountTableViewCell
            let initialNumberOfCopies = presenter.printingItem.numberOfCopies
            cell.configureCell(selected: Double(initialNumberOfCopies), valueDidChangeHandler: { [weak self] newValue in
                guard let self = self else { return }
                self.presenter.printingItem.numberOfCopies = newValue
            })
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.dataSource[section].sectionTitle
    }
    
    @objc func printButtonDidTap() {
        presenter.sendToPrinter()
    }

}
