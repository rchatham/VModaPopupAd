//
//  InfiniteScrollingCell.swift
//  InfiniteScrollingCollectionView
//
//  Created by Abhayam Rastogi on 6/20/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

import UIKit

public class InfiniteScrollingCell: UICollectionViewCell {

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
