//
//  MainScreenVC.swift
//  BrainPrinter
//
//  Created by Kirill on 29.08.22.
//

import UIKit

class MainScreenVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    private static let rowHeight: CGFloat = 300
    
    private var viewModel: MainScreenViewModelProtocol {
        let viewModel = MainScreenViewModel(delegate: self)
        return viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // FIXME: костыль с высотой
        tableViewHeight.constant = MainScreenVC.rowHeight * CGFloat(viewModel.dataSource.count)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MainScreenTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MainScreenTableViewCell.reusableID)
    }

}

extension MainScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainScreenVC.rowHeight
    }
}

extension MainScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.reusableID) as? MainScreenTableViewCell else {
            return UITableViewCell()
        }
        cell.title.text = viewModel.dataSource[indexPath.item]
        return cell
    }
}

extension MainScreenVC: MainScreenDelegate {
    func updateView() {
        
    }
    
}

