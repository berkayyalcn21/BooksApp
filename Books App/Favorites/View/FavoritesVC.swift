//
//  FavoritesVC.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    private let collectionViewKey = "FavoritesCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favoriler"
        setupUI()
    }
    
    func setupUI() {
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        registerCollectionView()
    }
    
    func registerCollectionView() {
        favoritesCollectionView.register(.init(nibName: collectionViewKey, bundle: nil), forCellWithReuseIdentifier: collectionViewKey)
    }
}

extension FavoritesVC: UICollectionViewDelegate {
    
}

extension FavoritesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewKey, for: indexPath) as! FavoritesCollectionViewCell
//        cell.favoritesActivityIndicator.stopAnimating()
        cell.favoritesTitle.text = "Kitap Adı"
        return cell
    }
}

extension FavoritesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (collectionView.frame.size.width - 30) / 2, height: 235)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
