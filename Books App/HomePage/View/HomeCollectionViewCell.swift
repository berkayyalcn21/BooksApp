//
//  HomeCollectionViewCell.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookStarButton: UIButton!
    @IBOutlet weak var cellActivityIndicator: UIActivityIndicatorView!
    var row: Int?
    var onTappedButton: ((Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func bookStarButtonTapped(_ sender: Any) {
        if let row {
            onTappedButton?(row)
        }
    }
}
