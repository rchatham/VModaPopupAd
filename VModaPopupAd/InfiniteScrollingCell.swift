//
//  InfiniteScrollingCell.swift
//  InfiniteScrollingCollectionView
//
//  Created by Abhayam Rastogi on 6/20/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

import UIKit

class InfiniteScrollingCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(photoName:String){
        imageView?.image = UIImage(named: photoName)
    }

}
