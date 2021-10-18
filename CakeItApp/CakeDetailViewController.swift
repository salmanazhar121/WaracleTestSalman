//
//  CakeDetailViewController.swift
//  CakeItApp
//
//  Created by David McCallum on 21/01/2021.
//

import UIKit

class CakeDetailViewController: UIViewController {
    
    @IBOutlet private weak var cakeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var cake : Cake?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.cake?.title
        descriptionLabel.text = self.cake?.desc
        
        self.loadImage()
        
    }
    
    func loadImage()
    {
        if let imageURL = URL(string: self.cake?.image ?? "")
        {
            self.cakeImageView.loadImage(at: imageURL)
        }
    }
}
