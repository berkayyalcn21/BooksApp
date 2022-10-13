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
    private var favoritesList: [BooksEntity] = []
    var favoritesPresenterObject: ViewToPresenterFavoritesProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesPresenterObject?.fetchData()
    }
    
    func setupUI() {
        self.title = "Favoriler"
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        registerCollectionView()
        FavoritesRouter.createModule(ref: self)
    }
    
    func registerCollectionView() {
        favoritesCollectionView.register(.init(nibName: collectionViewKey, bundle: nil), forCellWithReuseIdentifier: collectionViewKey)
    }
}

extension FavoritesVC: UICollectionViewDelegate {
    
}

extension FavoritesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = favoritesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewKey, for: indexPath) as! FavoritesCollectionViewCell
        cell.layer.cornerRadius = 10
        DispatchQueue.global().async { [weak self] in
            if cellModel.bookImage != nil {
                let data = try! Data(contentsOf: URL(string: cellModel.bookImage!)!)
                DispatchQueue.main.async { [weak self] in
                    guard let _ = self else { return }
                    cell.favoritesImageView.image = UIImage(data: data)
                    cell.favoritesActivityIndicator.stopAnimating()
                }
            }
        }
        cell.favoritesTitle.text = cellModel.title
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

extension FavoritesVC: PresenterToViewFavoritesProtocol {
    
    func dataTransferToView(favorites: Array<BooksEntity>) {
        self.favoritesList = favorites
        favoritesCollectionView.reloadData()
    }
}
