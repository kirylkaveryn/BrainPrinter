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
    
    private var viewModel: MainScreenViewModelProtocol {
        let viewModel = MainScreenViewModel(delegate: self)
        return viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // FIXME: костыль с высотой таблицы
        tableViewHeight.constant = MainScreenViewController.rowHeight * CGFloat(viewModel.dataSource.count)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MainScreenTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MainScreenTableViewCell.reusableID)
    }

}

extension MainScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainScreenViewController.rowHeight
    }
}

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.reusableID) as? MainScreenTableViewCell else {
            return UITableViewCell()
        }
        cell.title.text = viewModel.dataSource[indexPath.item]
//        cell.setupWith(model: )

        return cell
    }
}

extension MainScreenViewController: MainScreenDelegate {
    func updateView() {
        
    }
    
}

