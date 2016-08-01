//
//  InfiniteScrollingPageViewController.swift
//  VModaPopupAd
//
//  Created by Reid Chatham on 7/29/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit

class InfiniteScrollingPageViewController: UIPageViewController {
    
    var imageURLs : [String]
    
    init(imageURLs: [String]) {
        self.imageURLs = imageURLs
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension InfiniteScrollingPageViewController : UIPageViewControllerDelegate {
    
    func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func pageViewControllerPreferredInterfaceOrientationForPresentation(pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return UIPageViewControllerSpineLocation.None
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
}

extension InfiniteScrollingPageViewController : UIPageViewControllerDataSource {
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return imageURLs.count
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = (viewController as? ImageViewController)?.index else { return nil }
        let nextIndex = (currentIndex < imageURLs.count-1) ? currentIndex+1 : 0
        guard let image = UIImage(named: imageURLs[nextIndex]) else { return nil }
        return ImageViewController(image: image, index: nextIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = (viewController as? ImageViewController)?.index else { return nil }
        let prevIndex = (currentIndex > 0) ? currentIndex-1 : imageURLs.count-1
        guard let image = UIImage(named: imageURLs[prevIndex]) else { return nil }
        return ImageViewController(image: image, index: prevIndex)
    }
}

private class ImageViewController : UIViewController {
    
    private var image : UIImage
    private var index : Int
    
    private weak var imageView : UIImageView!
    
    init(image: UIImage, index: Int) {
        self.image = image
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: view.frame)
        imageView.image = image
        view = imageView
    }
}