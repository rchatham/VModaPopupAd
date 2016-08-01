//
//  ViewController.swift
//  VModaPopupAd
//
//  Created by Reid Chatham on 7/11/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit
import MerchScroller
import DJZPopupWebView


class ViewController: UIViewController {
    
    // Demo URL
    let url = NSURL(string: "https://v-moda.com/over-ear-on-ear")
    
    // Scroll View
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = self.view.bounds
        self.view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        scrollView.addConstraint(NSLayoutConstraint(
            item  : contentView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal,
            toItem: scrollView , attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: [], metrics: nil, views: ["contentView":contentView]))
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: [], metrics: nil, views: ["contentView":contentView]))
        
        
        let color = UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
        
        let label = UILabel()
        label.text = "PTPopupWebView Demo"
        label.textColor = color
        label.font = UIFont.boldSystemFontOfSize(24)
        label.frame = CGRectMake(0, 60, self.view.bounds.width, 60)
        label.textAlignment = .Center
        
        contentView.addSubview(label)
        
        var containerViews : [UIView] = []
        var lastView : UIView = label
        
        let margin : CGFloat = 8.0
        for (title, description) in demolist {
            let containerView = UIView()
            containerViews.append(containerView)
            
            containerView.translatesAutoresizingMaskIntoConstraints = false
            if title[title.startIndex] != "*" {
                containerView.tag = title.hash
                containerView.userInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapped(_:)))
                containerView.addGestureRecognizer(tap)
            }
            containerView.layer.cornerRadius = 8
            
            // Button
            let titleView : UIView
            if title[title.startIndex] == "*" {
                let sectionLabel = UILabel()
                sectionLabel.text = title.substringFromIndex(title.startIndex.advancedBy(1))
                sectionLabel.font = UIFont.boldSystemFontOfSize(24)
                sectionLabel.textAlignment = .Left
                sectionLabel.textColor = .darkGrayColor()
                
                titleView = sectionLabel
            }
            else {
                let titleLabel = UILabel()
                titleLabel.text = title
                titleLabel.font = UIFont.boldSystemFontOfSize(22)
                titleLabel.textAlignment = .Left
                titleLabel.textColor = color
                
                titleView = titleLabel
            }
            containerView.addSubview(titleView)
            titleView.frame = CGRectMake(0, 0, 0, 30)
            let labelsize = label.sizeThatFits(CGSizeMake(self.view.bounds.width - margin * 2, CGFloat.max))
            titleView.frame = CGRectMake(margin, 0, labelsize.width, labelsize.height)
            titleView.sizeToFit()
            
            
            // Description
            let descriptionLabel = UILabel()
            descriptionLabel.text = description
            descriptionLabel.textColor = .darkGrayColor()
            descriptionLabel.font = UIFont.systemFontOfSize(14)
            
            containerView.addSubview(descriptionLabel)
            descriptionLabel.numberOfLines = 0
            let size = descriptionLabel.sizeThatFits(CGSizeMake(self.view.bounds.width - margin * 2, CGFloat.max))
            descriptionLabel.frame = CGRectMake(margin, 0, size.width, size.height)
            descriptionLabel.sizeToFit()
            
            contentView.addSubview(containerView)
            
            let views = ["containerView":containerView, "lastView": lastView, "titleView" : titleView, "descriptionLabel" : descriptionLabel]
            titleView.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            let margin = description == "" ? 0 : 8
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[titleView]-0-[descriptionLabel]-\(margin)-|", options: [], metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[titleView]-8-|", options: [], metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[descriptionLabel]-8-|", options: [], metrics: nil, views: views))
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[lastView][containerView]", options: [], metrics: nil, views: views))
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[containerView]-8-|", options: [], metrics: nil, views: views))
            lastView = containerView
        }
        contentView.layoutSubviews()
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[lastView]-32-|", options: [], metrics: nil, views: ["lastView": lastView]))
        contentView.frame = CGRectMake(0, 0, scrollView.bounds.width, lastView.frame.origin.y + lastView.frame.height + 32)
        scrollView.contentSize = contentView.bounds.size
        
//        lastView.userInteractionEnabled = true
//        let tap = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.pressed(_:)))
//        lastView.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tapped (sender: UIGestureRecognizer) {
//        let url = NSURL(string: "https://github.com/pjocprac/PTPopupWebView/blob/master/README.md")
        
        // Initialize and set URL
        let vc : PTPopupWebViewController = PTPopupWebViewController()
        
        let style = PTPopupWebViewControllerStyle()
            .titleBackgroundColor(.blackColor())
            .titleForegroundColor(.whiteColor())
            .backgroundColor(.blackColor())
            .buttonBackgroundColor(.blackColor())
            .buttonForegroundColor(.whiteColor())
            .innerMargin(UIEdgeInsetsMake(0,10,0,10))
            .titleFont(UIFont.djzFont(22))
            .buttonFont(UIFont.djzFont(17))
            .buttonDistribution(.Equal)
        
        vc.popupView.style(style)
        
//        vc.popupView.viewType = .Web(URL: url)
        
        let merch = ["merch-1","merch-2","merch-3","merch-4"]
        
        if let view = sender.view {
            let popup = {
                switch view.tag {
                
                case "VModaPopup".hash:
                    
                    vc.popupView.viewType = .Image(image: UIImage(named: "crossfade")!)
                    
                    vc.popupView.style(vc.popupView.style!.innerMargin(UIEdgeInsetsMake(10,10,10,10)))
                    
                    vc.popupView
                        .title("VMODA HEADPHONES!")
                        .addExternalLinkPattern(.URLScheme)
                        .addButton(PTPopupWebViewButton(type: .LinkClose(NSURL(string: "https://v-moda.com/over-ear-on-ear")!)).title("$429.00!!"))
                        .addButton(PTPopupWebViewButton(type: .Close).useDefaultImage().title("CLOSE"))
                    
                    // show PTPopupWebViewController
                    vc.show() {
                        print("Closed popupView")
                    }
                    
                case "MerchPopup".hash:
                    
//                    let merchScroller = InfiniteScrollingView(frame: CGRectZero, photoURLs: merch)
                    let merchScroller = MerchScroller(frame: CGRectZero, photoURLs: merch)
                    
                    merchScroller.didSelectCellAtIndex = { index in
                        // Link to merch item in store
                    }
                    
                    merchScroller.pagingEnabled = false
                    merchScroller.scrollEnabled = true
                    
                    let layout = (merchScroller.collectionViewLayout as! UICollectionViewFlowLayout)
                    layout.scrollDirection = .Horizontal
                    layout.minimumLineSpacing = 10
                    layout.minimumInteritemSpacing = 10
                    
                    vc.popupView.viewType = .Custom(view: merchScroller)
                    
//                    let merchScroller = InfiniteScrollingPageViewController(imageURLs: merch)
//                    vc.addChildViewController(merchScroller)
//                    vc.popupView.viewType = .Custom(view: merchScroller.view)
                    
                    vc.popupView
                        .title("CROSSFADER MERCH!")
                        .addExternalLinkPattern(.URLScheme)
                        .addButton(PTPopupWebViewButton(type: .LinkClose(NSURL(string: "https://teespring.com/stores/crossfader")!)).title("$17.99 AND UP!"))
                        .addButton(PTPopupWebViewButton(type: .Close).useDefaultImage().title("CLOSE"))
                    
                    
                    // show PTPopupWebViewController
                    vc.show() {
                        print("Closed popupView")
                    }
                    
                case "ClubCrossfaderPopup".hash:
                    
                    vc.popupView.viewType = .Web(URL: NSURL(string: "https://crossfader.fm/chat"))
                    vc.popupView.style(vc.popupView.style!.innerMargin(UIEdgeInsetsMake(10,10,10,10)))
                    
                    vc.popupView
                        .title("CLUB CROSSFADER!")
                        .addExternalLinkPattern(.URLScheme)
                        .addButton(PTPopupWebViewButton(type: .LinkClose(NSURL(string: "https://crossfader.fm/chat")!)).title("$5/MONTH!"))
                        .addButton(PTPopupWebViewButton(type: .Close).useDefaultImage().title("CLOSE"))
                    
                    
                    // show PTPopupWebViewController
                    vc.show() {
                        print("Closed popupView")
                    }
                    
                case "StorePopup".hash:
                    
                    let merchCoordinator = MerchCoordinator(popupViewController: vc)
                    
                    merchCoordinator.presentStoreFromViewController(self, completion: nil)
                    
                default: break
                }
                
            }
            
            // touch animation
            UIView.animateWithDuration(
                0.25,
                animations: {
                    view.backgroundColor = UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 0.2)
                },
                completion: { _ in
                    UIView.animateWithDuration(
                        0.25,
                        animations: {
                            view.backgroundColor = .clearColor()
                        },
                        completion: { _ in
                            popup()
                        }
                    )
                }
            )
        }
    }
    
//    func pressed (sender: UIGestureRecognizer) {
//        switch (sender.state) {
//        case .Began:
//            if let view = sender.view {
//                let popup = PTPopupWebView(frame: CGRectMake(10, 40, UIScreen.mainScreen().bounds.width - 20, view.frame.origin.y - scrollView.contentOffset.y - 50))
//                let style = PTPopupWebViewStyle()
//                    .titleHidden(true)
//                    .buttonHidden(true)
//                popup
//                    .URL(string: "https://v-moda.com/")
//                    .style(style)
//                
//                popup.layer.masksToBounds = false
//                popup.layer.shadowOffset = CGSizeMake(2.0, 2.0)
//                popup.layer.shadowOpacity = 0.3
//                popup.layer.shadowColor = UIColor.lightGrayColor().CGColor
//                popup.layer.shadowRadius = 2.0
//                self.view.addSubview(popup)
//            }
//        case .Ended, .Cancelled:
//            for view in self.view.subviews {
//                if let popup = view as? PTPopupWebView {
//                    popup.removeFromSuperview()
//                }
//            }
//            break
//        default:
//            break
//        }
//    }
    
    // Demo List [Title:description]
    private var demolist : [(String,String)] = [
        ("VModaPopup",
            "VModa popup preview."),
        ("MerchPopup",
            "Merch popup preview."),
        ("ClubCrossfaderPopup",
            "Club Crossfader popup preview."),
        ("StorePopup",
            "Store popup preview.")
    ]
}



