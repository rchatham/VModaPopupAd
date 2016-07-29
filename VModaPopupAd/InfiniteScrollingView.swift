////
//  InfiniteScrollingViewController.swift
//  InfiniteScrollingCollectionView
//
//  Created by Abhayam Rastogi on 6/19/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

import UIKit

public protocol InfiniteScrollingViewDelegate: class {
    func infiniteScrollingView(infiniteScrollingView: InfiniteScrollingView, didSelectMerchItemAtIndexPath: NSIndexPath)
}

public class InfiniteScrollingView: UICollectionView {
    
    weak public var infiniteScrollViewDelegate: InfiniteScrollingViewDelegate?
    
    public init(frame: CGRect, useSampleData: Bool = false) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        if useSampleData { setPhotoURLs(["merch-1","merch-2","merch-3","merch-4"]) }
        setup()
    }
    
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
        photosUrlArray = [urls[urls.count-1]] + urls + [urls[0]]
    }
    
    
    //MARK: Private
    
    private var photosUrlArray = [String]()
    
    private lazy var onceScroller: Void = { [weak self] in
        let indexPath = NSIndexPath(forItem: 1, inSection: 0)
        self?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated:false)
    }()
    
    private func photoForIndexPath(indexPath: NSIndexPath) -> String {
        return photosUrlArray[indexPath.row]
    }
    
    private func setup() {
        delegate = self
        dataSource = self
        pagingEnabled = true
        
        registerClass(InfiniteScrollingCell.self, forCellWithReuseIdentifier: String(InfiniteScrollingCell))
    }
}

extension InfiniteScrollingView : UICollectionViewDataSource{
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUrlArray.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(InfiniteScrollingCell), forIndexPath: indexPath) as! InfiniteScrollingCell
        let photoName = photoForIndexPath(indexPath)
        
        cell.configureCell(photoName)
        
        return cell
    }
}

extension InfiniteScrollingView : UICollectionViewDelegate {
    
    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        _ = onceScroller
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        infiniteScrollViewDelegate?.infiniteScrollingView(self, didSelectMerchItemAtIndexPath: indexPath)
    }
}

extension InfiniteScrollingView : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width - 10, height: size.height - 10)
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsetsMake(5, 5, 5, 5)
    }
}

extension InfiniteScrollingView : UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // Calculate where the collection view should be at the right-hand end item
        let contentOffsetWhenFullyScrolledRight = self.frame.size.width * CGFloat(self.photosUrlArray.count - 1)
        
        if (scrollView.contentOffset.x == contentOffsetWhenFullyScrolledRight) {
            
            // user is scrolling to the right from the last item to the 'fake' item 1.
            // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
            
            let indexPath = NSIndexPath(forItem: 1, inSection: 0)
            self.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated:false)
            
        } else if (scrollView.contentOffset.x == 0)  {
            
            // user is scrolling to the left from the first item to the fake 'item N'.
            // reposition offset to show the 'real' item N at the right end end of the collection view
            
            let newIndexPath = NSIndexPath(forItem: (self.photosUrlArray.count - 2), inSection:0)
            self.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: .CenteredHorizontally, animated:false)
            
        }
    }
}



