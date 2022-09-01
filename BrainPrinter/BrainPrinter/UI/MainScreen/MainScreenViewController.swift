//
//  MainScreenViewController.swift
//  BrainPrinter
//
//  Created by Kirill on 29.08.22.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter: MainScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
    
    func configure(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "crown"), style: .plain, target: nil, action: nil)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MainScreenCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MainScreenCollectionViewCell.reusableID)
    }
    
}

// MARK: - CollectionView Delegate and DataSource methods
extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
}

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionViewCell.reusableID, for: indexPath) as! MainScreenCollectionViewCell
        cell.configure(model: presenter?.dataSource[indexPath.item])
        return cell
    }
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right, height: 150)
    }
}
