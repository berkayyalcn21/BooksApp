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
    var result: Result?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: #selector(starred))
        self.title = "Detay"
        fetchData()
    }
    
    func fetchData() {
        if let result {
            DispatchQueue.global().async { [weak self] in
                let data = try! Data(contentsOf: URL(string: result.artworkUrl100!)!)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.detailsImageView.image = UIImage(data: data)
                }
            }
        }
        detailsBookName.text = result?.name
        detailsBookAuthor.text = result?.artistName
        detailsDate.text = result?.releaseDate
    }
    
    @objc func starred() {
        print("Clicked")
    }
}
