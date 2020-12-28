//
//  FoodListViewController.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit

final class FoodListViewController: UIViewController, PagedController {
    var pageName: String = "Food"
    var pageIndex: Int = 0
    var pagesTitle = [String]()
    var images = [String]()
    
    private let cellReuseID = FoodListViewController.className
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var dataSource = makeDataSource()
    
    @IBOutlet weak var checkoutButton: CartButton!
    
    var configurator: FoodListConfigurator! = FoodListConfiguratorImpl(foodCategory: .pizza)
    var presenter: FoodListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(foodListViewController: self)
        presenter.fetchFoodList()
        
        self.configureCollectionView()
        self.configureHeader()
        self.addCheckoutAction(to: checkoutButton)
        
    }
    
    static func returnController() -> FoodListViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(withIdentifier: FoodListViewController.className) as! FoodListViewController
    }
    
    func addCheckoutAction(to cartButton: CartButton) {
        cartButton.cartButtonAction = { [weak self] in
            self?.presenter.checkoutToCart()
        }
    }

}

extension FoodListViewController: FoodListView {
    func didFetchFoodListSuccess() {
        self.applySnapshot()
    }
    
    func didFetchFoodListError(title: String, message: String) {
        let alert = AlertController.infoAlert(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }
    
}

enum Section { case main }
typealias FoodDataSource = UICollectionViewDiffableDataSource<Section, Food>
typealias FoodListSnapshot = NSDiffableDataSourceSnapshot<Section, Food>

extension FoodListViewController {
    func makeDataSource() -> FoodDataSource {
        let reuseIdentifier = cellReuseID
        return FoodDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, food in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodCell
            self?.presenter.configure(cell: cell, for: indexPath)
            return cell
        })
    }
    
    func configureHeader() {
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard kind == UICollectionView.elementKindSectionHeader else {
              return nil
            }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FoodHeaderView.reuseIdentifier, for: indexPath) as? FoodHeaderView
            header?.backgroundColor = .lightGray
            header?.images = self?.images as! [String]
            header?.titleArr = self?.pagesTitle ?? [String]()
            return header
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = FoodListSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(presenter.foodItems)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func configureCollectionView() {
        collectionView.collectionViewLayout = configureLayout()
        
        collectionView.register(UINib(nibName: FoodCell.className, bundle: nil), forCellWithReuseIdentifier: cellReuseID)
        
        collectionView.register( FoodHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FoodHeaderView.reuseIdentifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(375))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let count = UIDevice.isPhone ? 1 : 3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: count)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        
        let layout =  UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1), heightDimension: NSCollectionLayoutDimension.absolute(375))
                
            let itemCount =  UIDevice.isPhone ? 1 : 3
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.interGroupSpacing = 10
            // Supplementary header view setup
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        })
        
        return layout
    }
    
}

