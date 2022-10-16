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
    var starButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()

        starButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .done, target: self, action: #selector(starred))
        navigationItem.rightBarButtonItem = starButton
        self.title = "Detay"
        DetailsRouter.createModule(ref: self)
        fetchData()
        checkStarButton()
    }

    // Fetch book data
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
    
    // Star button color check
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
    
    // Star button action
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
                let book = DataTransform.shared.transformDetailsEntityToBookEntity(detailsEntity: result)
                detailsPresenterObject?.addFavoriteBook(bookEntity: book)
            }
        }
        checkStarButton()
    }
}
