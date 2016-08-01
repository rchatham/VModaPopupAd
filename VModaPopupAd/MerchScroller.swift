//
//  MerchScroller.swift
//  VModaPopupAd
//
//  Created by Reid Chatham on 7/29/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit

public protocol MerchScrollerDelegate: class {
    func merchScroller(merchScroller: MerchScroller, didSelectCellAtIndex: Int)
}

public class MerchScroller: UICollectionView {
    
    weak public var merchScrollerDelegate: MerchScrollerDelegate?
    
    public var didSelectCellAtIndex = { (index: Int) in}
    
    public init(frame: CGRect, photoURLs: [String]) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setPhotoURLs(photoURLs)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func setPhotoURLs(urls: [String]) {
        guard !urls.isEmpty else { return }
        photosUrlArray = urls
    }
    
    
    //MARK: Private
    
    private var photosUrlArray = [String]()
    
    private func photoForIndexPath(indexPath: NSIndexPath) -> String {
        return photosUrlArray[indexPath.row]
    }
    
    private func setup() {
        delegate = self
        dataSource = self
        
        let nib = UINib(nibName: String(MerchCell), bundle: NSBundle(forClass: MerchScroller.self))
        registerNib(nib, forCellWithReuseIdentifier: String(MerchCell))
    }
}

extension MerchScroller : UICollectionViewDataSource{
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUrlArray.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(MerchCell), forIndexPath: indexPath) as! MerchCell
        let photoName = photoForIndexPath(indexPath)
        
        cell.configureCell(photoName)
        
        return cell
    }
}

extension MerchScroller : UICollectionViewDelegate {
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        merchScrollerDelegate?.merchScroller(self, didSelectCellAtIndex: indexPath.item)
        didSelectCellAtIndex(indexPath.item)
    }
}

extension MerchScroller : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let size = collectionView.frame.size
        return CGSize(width: size.width - layout.minimumInteritemSpacing*2, height: size.height - layout.minimumLineSpacing*2)
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
//        let layout = collectionViewLayout as! UICollectionViewFlowLayout
//        let top_bottom = layout.minimumLineSpacing
//        let left_right = layout.minimumInteritemSpacing
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}