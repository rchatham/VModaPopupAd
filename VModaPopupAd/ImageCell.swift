//
//  ImageCell.swift
//  VModaPopupAd
//
//  Created by Reid Chatham on 7/26/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureForObject(object: UIImage) {
        imageView.image = object
    }

}
