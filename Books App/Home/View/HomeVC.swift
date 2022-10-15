//
//  ViewController.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var homeActivityIndicator: UIActivityIndicatorView!
    var homePresenterObject: ViewToPresenterHomeProtocol?
    private let collectionViewKey = "HomeCollectionViewCell"
    private var booksList: [BooksList] = []
    private var paginationTotal = 20
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: #selector(filterButtonTapped))
        self.title = "Anasayfa"
        setupUI()
        HomeRouter.createModule(ref: self)
        filterButtonFunc(.All)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeCollectionView.reloadData()
    }

    private func setupUI() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        registerCollectionView()
        homeCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
    }
    
    @objc private func refreshCollection() {
        homeCollectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // CollectionView register
    func registerCollectionView() {
        homeCollectionView.register(.init(nibName: collectionViewKey, bundle: nil), forCellWithReuseIdentifier: collectionViewKey)
    }
    
    @objc func filterButtonTapped() {
        actionSheetForFilter()
    }
    
    func filterButtonFunc(_ type: FilterButton) {
        homePresenterObject?.filterButton = type
        homePresenterObject?.loadBooks(pagination: paginationTotal)
        homePresenterObject?.filteredList()
    }
    
    // Filter home page - actionSheet
    func actionSheetForFilter() {
        let actionSheet = UIAlertController(title: "Sırala", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Tümü", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.filterButtonFunc(.All)
        }))
        actionSheet.addAction(UIAlertAction(title: "Yeniden eskiye", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.filterButtonFunc(.NewToOld)
        }))
        actionSheet.addAction(UIAlertAction(title: "Eskiden yeniye", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.filterButtonFunc(.OldToNew)
        }))
        actionSheet.addAction(UIAlertAction(title: "Sadece beğenilenler", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.filterButtonFunc(.Favorites)
        }))
        actionSheet.addAction(UIAlertAction(title: "Vazgeç", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    // Add core data func - star button action
    func starButtonTapped(_ cellModel: BooksList) {
        var check: Bool = false
        if let booksList = homePresenterObject?.fetchCoreDataList() {
            for i in booksList {
                if i.id == cellModel.id && cellModel.id != nil {
                    homePresenterObject?.deleteFavoriteBook(cellModel.id!)
                    check = true
                }
            }
            if !check && cellModel.id != nil && cellModel.name != nil && cellModel.artworkUrl100 != nil && cellModel.artistName != nil && cellModel.releaseDate != nil {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let stringDate = dateFormatter.string(from: cellModel.releaseDate ?? .now)
                homePresenterObject?.addFavoriteBook(cellModel.id!,
                                                     cellModel.name!,
                                                     cellModel.artworkUrl100!,
                                                     cellModel.artistName!,
                                                     stringDate)
            }
        }
    }
}

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = DataTransform.shared.transformToDetails(booksList)[indexPath.row]
        let details = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        details.result = cellModel
        navigationController?.pushViewController(details, animated: true)
    }
}

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        homeActivityIndicator.stopAnimating()
        let cellModel = booksList[indexPath.row]
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: collectionViewKey, for: indexPath) as! HomeCollectionViewCell
        cell.layer.cornerRadius = 10
        
        // Data transform for cell image
        DispatchQueue.global().async { [weak self] in
            let data = try! Data(contentsOf: URL(string: cellModel.artworkUrl100!)!)
            DispatchQueue.main.async { [weak self] in
                guard let _ = self else { return }
                cell.bookImageView.image = UIImage(data: data)
                cell.cellActivityIndicator.stopAnimating()
            }
        }
        
        // Star button color check
        cell.bookStarButton.tintColor = .gray
        if let booksList = homePresenterObject?.fetchCoreDataList() {
            for i in booksList {
                if i.id == cellModel.id {
                    cell.bookStarButton.tintColor = .yellow
                }
            }
        }
        
        // Star button tapped
        cell.row = indexPath.row
        cell.onTappedButton = { [weak self] index in
            guard let self = self else { return }
            self.starButtonTapped(cellModel)
            self.homeCollectionView.reloadItems(at: [indexPath])
        }
        cell.bookTitle.text = cellModel.name
        return cell
    }
    
    // Pagination settings
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 1 == paginationTotal {
            paginationTotal += 20
            homePresenterObject?.loadBooks(pagination: paginationTotal)
        }
    }
}

// CollectionView size settings
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
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

extension HomeVC: PresenterToViewHomeProtocol {
    
    func updateData(with booksList: [BooksList]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.booksList = booksList
            self.homeCollectionView.reloadData()
        }
    }
    
    func updateError(with error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.booksList = []
            self.homeCollectionView.reloadData()
            print(error)
        }
    }
    
    
}
