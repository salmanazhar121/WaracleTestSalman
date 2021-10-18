//
//  CakeTableViewCell.swift
//  CakeItApp
//
//  Created by David McCallum on 21/01/2021.
//

import UIKit

class CakeTableViewCell: UITableViewCell {
    @IBOutlet weak var cakeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func prepareForReuse() {
        cakeImageView.image = nil
        cakeImageView.cancelImageLoad()
    }
}
