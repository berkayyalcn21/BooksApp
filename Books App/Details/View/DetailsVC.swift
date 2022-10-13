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
    var dataType: DataType?
    var result: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: #selector(starred))
        self.title = "Detay"
        DetailsRouter.createModule(ref: self)
        fetchData()
    }
    
    enum DataType {
        case Books
        case BooksEntity
    }
    
    func fetchData() {
        switch dataType {
        case .Books:
            if let result = result as? Books {
                DispatchQueue.global().async { [weak self] in
                    let data = try! Data(contentsOf: URL(string: result.artworkUrl100!)!)
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.detailsImageView.image = UIImage(data: data)
                    }
                }
                
                detailsBookName.text = result.name
                detailsBookAuthor.text = result.artistName
                detailsDate.text = result.releaseDate
            }
        case .BooksEntity:
            if let result = result as? BooksEntity {
                DispatchQueue.global().async { [weak self] in
                    let data = try! Data(contentsOf: URL(string: result.bookImage!)!)
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.detailsImageView.image = UIImage(data: data)
                    }
                }
                
                detailsBookName.text = result.title
                detailsBookAuthor.text = result.authorName
                detailsDate.text = result.bookDate
            }
        case .none: break
        }
        
    }
    
    @objc func starred() {
        print("Clicked")
    }
}
