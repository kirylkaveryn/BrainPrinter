//
//  MainScreenViewController.swift
//  BrainPrinter
//
//  Created by Kirill on 29.08.22.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter: MainScreenPresenterProtocol!
    
    // MARK: - Lifcycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    // MARK: - Setup methods
    func configure(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        presenter.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "crown"), style: .plain, target: nil, action: nil)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MainScreenCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MainScreenCollectionViewCell.reusableID)
        collectionView.register(UINib(nibName: MainScreenSectionHeader.nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainScreenSectionHeader.reusableID)
    }
    
}

// MARK: - Delegate methods
extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.resourceManager.mainScreenCollectionDataSource.count
    }

}

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionViewCell.reusableID, for: indexPath) as! MainScreenCollectionViewCell
        cell.setupWith(model: presenter.resourceManager.mainScreenCollectionDataSource[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainScreenSectionHeader.reusableID, for: indexPath) as! MainScreenSectionHeader
            header.headerTitle.text = "Printer"
            return header
        default:
            return UICollectionReusableView()
        }
        
    }
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        // get the optimal dynamic size of the header
        return headerView.systemLayoutSizeFitting(
            CGSize(width: collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right,
                   height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}

extension MainScreenViewController: MainScreenDelegate {
    func updateView() {
        
    }
}
