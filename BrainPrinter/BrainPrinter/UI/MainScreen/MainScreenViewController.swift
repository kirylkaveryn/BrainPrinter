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
    
    private var viewModel: MainScreenViewModelProtocol?
    
    // MARK: - Lifcycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // FIXME: костыль с высотой таблицы
        tableViewHeight.constant = MainScreenViewController.rowHeight * CGFloat(viewModel?.dataSource.count ?? 0)

    }
    
    // MARK: - Setup methods
    private func setupViewModel() {
        viewModel = MainScreenViewModel(delegate: self)
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
}

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.reusableID) as! MainScreenTableViewCell
        cell.title.text = viewModel?.dataSource[indexPath.item]
//        cell.setupWith(model: )

        return cell
    }
}

extension MainScreenViewController: MainScreenDelegate {
    func updateView() {
        
    }
}

