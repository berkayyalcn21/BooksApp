//
//  FavoritesCollectionViewCell.swift
//  Books App
//
//  Created by Berkay on 13.10.2022.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoritesTitle: UILabel!
    @IBOutlet weak var favoritesImageView: UIImageView!
    @IBOutlet weak var favoritesActivityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
