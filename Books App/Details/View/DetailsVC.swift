//
//  DetailsVC.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsBookName: UILabel!
    @IBOutlet weak var detailsBookAuthor: UILabel!
    @IBOutlet weak var detailsDate: UILabel!
    var detailsPresenterObject: ViewToPresenterDetailsProtocol?
    var result: DetailsEntity?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: #selector(starred))
        self.title = "Detay"
        DetailsRouter.createModule(ref: self)
        fetchData()
    }

    func fetchData() {
        if let result {
            DispatchQueue.global().async { [weak self] in
                let data = try! Data(contentsOf: URL(string: result.imageView!)!)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.detailsImageView.image = UIImage(data: data)
                }
            }
            
            detailsBookName.text = result.bookTitle
            detailsBookAuthor.text = result.authorName
            detailsDate.text = result.bookDate
        }
    }
    
    @objc func starred() {
//        var check: Bool = false
//        if let booksList = detailsPresenterObject?.fetchCoreDataList() {
//            for i in booksList {
//                if i.id == result.id && result.id != nil {
//                    homePresenterObject?.deleteFavoriteBook(result.id!)
//                    check = true
//                }
//            }
//            if !check && cellModel.id != nil && cellModel.name != nil && cellModel.artworkUrl100 != nil && cellModel.artistName != nil && cellModel.releaseDate != nil {
//                homePresenterObject?.addFavoriteBook(cellModel.id!, cellModel.name!, cellModel.artworkUrl100!, cellModel.artistName!, cellModel.releaseDate!)
//            }
//        }
    }
}
