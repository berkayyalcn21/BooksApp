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
    let starButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .done, target: DetailsVC.self, action: #selector(starred))

    override func viewDidLoad() {
        super.viewDidLoad()

    
        navigationItem.rightBarButtonItem = starButton
        self.title = "Detay"
        DetailsRouter.createModule(ref: self)
        fetchData()
        checkStarButton()
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
    
    func checkStarButton() {
        guard let result else { return }
        starButton.tintColor = .gray
        if let booksList = detailsPresenterObject?.fetchCoreDataList() {
            for i in booksList {
                if i.id == result.id && result.id != nil {
                    starButton.tintColor = .yellow
                }
            }
        }
    }
    
    @objc func starred() {
        guard let result else { return }
        var check: Bool = false
        if let booksList = detailsPresenterObject?.fetchCoreDataList() {
            for i in booksList {
                if i.id == result.id && result.id != nil {
                    detailsPresenterObject?.deleteFavoriteBook(result.id!)
                    check = true
                }
            }
            if !check {
                detailsPresenterObject?.addFavoriteBook(result.id!, result.bookTitle!, result.imageView!, result.authorName!, result.bookDate!)
            }
        }
        checkStarButton()
    }
}
