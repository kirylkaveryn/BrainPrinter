//
//  MainScreenViewController.swift
//  BrainPrinter
//
//  Created by Kirill on 29.08.22.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    private static let rowHeight: CGFloat = 200
    
    private var presenter: MainScreenPresenterProtocol!
    
    // MARK: - Lifcycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // FIXME: костыль с высотой таблицы
        tableViewHeight.constant = MainScreenViewController.rowHeight * CGFloat(presenter.resourceManager.mainScreenCollectionDataSource.count)

    }
    
    // MARK: - Setup methods
    func configure(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        presenter.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "crown"), style: .plain, target: nil, action: nil)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MainScreenTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MainScreenTableViewCell.reusableID)
    }
    
}

// MARK: - Delegate methods
extension MainScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainScreenViewController.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.resourceManager.mainScreenCollectionDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.reusableID, for: indexPath) as! MainScreenTableViewCell
//        cell.title.text = presenter?.resourceManager.mainScreenCollectionDataSource[indexPath.item]
        // FIXME: - remove !
        cell.setupWith(model: presenter.resourceManager.mainScreenCollectionDataSource[indexPath.item])

        return cell
    }
}

extension MainScreenViewController: MainScreenDelegate {
    func updateView() {
        
    }
}

