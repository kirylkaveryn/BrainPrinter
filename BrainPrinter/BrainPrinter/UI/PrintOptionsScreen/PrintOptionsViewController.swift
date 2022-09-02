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
        tableView.register(UINib(nibName: ImageOrientationTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ImageOrientationTableViewCell.reusableID)
        tableView.register(UINib(nibName: ImagesPerPageTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ImagesPerPageTableViewCell.reusableID)
        tableView.register(UINib(nibName: ImageContentTypeTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ImageContentTypeTableViewCell.reusableID)
        tableView.register(UINib(nibName: ImagesCountTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ImagesCountTableViewCell.reusableID)
        tableView.register(UINib(nibName: PosterPagesWideTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PosterPagesWideTableViewCell.reusableID)
        tableView.register(UINib(nibName: PosterPreviewTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PosterPreviewTableViewCell.reusableID)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.dataSource[section].numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (CGFloat)(presenter.dataSource[indexPath.section].rowHeight)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = presenter.dataSource[indexPath.section]
        let valueDidChangeHandler = section.valueDidChangeHandler

        switch section.printOptions {
        case .imageOrientaion(let cases):
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageOrientationTableViewCell.reusableID, for: indexPath) as! ImageOrientationTableViewCell
            let selectedCase = presenter.imageOrientation
            cell.configureCell(orientations: cases, selected: selectedCase, valueDidChangeHandler: valueDidChangeHandler)
            return cell

        case .imagesPerPage(let cases):
            let cell = tableView.dequeueReusableCell(withIdentifier: ImagesPerPageTableViewCell.reusableID, for: indexPath) as! ImagesPerPageTableViewCell
            let selectedCase = presenter.imagesPerPageCount
            cell.configureCell(countCases: cases, selected: selectedCase, valueDidChangeHandler: valueDidChangeHandler)
            return cell

        case .imageContentType(let cases):
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageContentTypeTableViewCell.reusableID, for: indexPath) as! ImageContentTypeTableViewCell
            let contentType = cases[indexPath.row]
            cell.configureCell(contentType: contentType, valueDidChangeHandler: valueDidChangeHandler)
            if contentType == presenter.imageContentType {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
            return cell

        case .imagesCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImagesCountTableViewCell.reusableID, for: indexPath) as! ImagesCountTableViewCell
            let initialNumberOfCopies = presenter.numberOfCopies
            cell.configureCell(selected: Double(initialNumberOfCopies), valueDidChangeHandler: valueDidChangeHandler)
            return cell
        
        case .posterShouldBe:
            let cell = tableView.dequeueReusableCell(withIdentifier: PosterPagesWideTableViewCell.reusableID, for: indexPath) as! PosterPagesWideTableViewCell
            let initialNumberOfCopies = presenter.pagesWide
            cell.configureCell(selected: Double(initialNumberOfCopies), valueDidChangeHandler: valueDidChangeHandler)
            return cell
        
        case .preview:
            let cell = tableView.dequeueReusableCell(withIdentifier: PosterPreviewTableViewCell.reusableID, for: indexPath) as! PosterPreviewTableViewCell
            cell.imagePreview.image = presenter.images.first
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
