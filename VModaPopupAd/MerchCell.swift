//
//  MerchCell.swift
//  VModaPopupAd
//
//  Created by Reid Chatham on 7/29/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit

public class MerchCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView?.image = image
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private var image: UIImage? {
        didSet {
            imageView?.image = image
        }
    }
    
    public func configureCell(photoName:String) {
        guard let image = UIImage(named: photoName) else {
            fatalError("Image not found!")
        }
        print("set Cell Image")
        self.image = image
    }

}
