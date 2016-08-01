//
//  MerchCoordinator.swift
//  VModaPopupAd
//
//  Created by Reid Chatham on 7/29/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit
import DJZPopupWebView

public struct MerchCoordinator {
    
    private let merch = ["merch-1","merch-2","merch-3","merch-4"]
    
    private let popupViewController : PTPopupWebViewController
    
    public init(popupViewController: PTPopupWebViewController) {
        self.popupViewController = popupViewController
        
        self.popupViewController.popupView.style(self.popupViewController.popupView.style!.closeButtonHidden(false))
    }
    
    public func presentStoreFromViewController(viewController: UIViewController, completion: (Void->Void)?) {
        
        popupViewController.popupView.viewType = .Image(image: UIImage(named: "crossfade")!)
        popupViewController.popupView
            .title("VMODA HEADPHONES!")
            .addExternalLinkPattern(.URLScheme)
            .addButton(setToMerch())
            .addButton(PTPopupWebViewButton(type: .LinkClose(NSURL(string: "https://v-moda.com/over-ear-on-ear")!)).title("429.00!"))
            .addButton(setToClubCrossfader())
        
        popupViewController.show(viewController, completion: completion)
    }
    
    private func setToMerch() -> PTPopupWebViewButton {
        return PTPopupWebViewButton(type: .Custom).title("MERCH!").handler {
            
            self.popupViewController.popupView.removeButtons()
            
            let merchScroller = MerchScroller(frame: CGRectZero, photoURLs: self.merch)
            
            merchScroller.didSelectCellAtIndex = { index in
                // Link to merch item in store
            }
            
            merchScroller.pagingEnabled = false
            merchScroller.scrollEnabled = true
            
            let layout = (merchScroller.collectionViewLayout as! UICollectionViewFlowLayout)
            layout.scrollDirection = .Horizontal
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            
            self.popupViewController.popupView.viewType = .Custom(view: merchScroller)
            self.popupViewController.popupView
                .title("CROSSFADER MERCH!")
                .addExternalLinkPattern(.URLScheme)
                .addButton(self.setToClubCrossfader())
                .addButton(PTPopupWebViewButton(type: .LinkClose(NSURL(string: "http://teespring.com/stores/crossfader")!)).title("17.99 AND UP!"))
                .addButton(self.setToVModa())
        }
    }
    
    private func setToVModa() -> PTPopupWebViewButton  {
        return PTPopupWebViewButton(type: .Custom).title("VMODA!").handler {
            
            self.popupViewController.popupView.removeButtons()
            
            self.popupViewController.popupView.viewType = .Image(image: UIImage(named: "crossfade")!)
            self.popupViewController.popupView
                .title("VMODA HEADPHONES!")
                .addExternalLinkPattern(.URLScheme)
                .addButton(self.setToMerch())
                .addButton(PTPopupWebViewButton(type: .LinkClose(NSURL(string: "https://v-moda.com/over-ear-on-ear")!)).title("429.00!"))
                .addButton(self.setToClubCrossfader())
        }
    }
    
    private func setToClubCrossfader() -> PTPopupWebViewButton  {
        return PTPopupWebViewButton(type: .Custom).title("CLUB!").handler {
            
            self.popupViewController.popupView.removeButtons()
            
            self.popupViewController.popupView.viewType = .Web(URL: NSURL(string: "https://crossfader.fm/chat"))
            self.popupViewController.popupView
                .title("CLUB CROSSFADER!")
                .addExternalLinkPattern(.URLScheme)
                .addButton(self.setToVModa())
                .addButton(PTPopupWebViewButton(type: .LinkClose(NSURL(string: "https://crossfader.fm/chat")!)).title("$5/MONTH!"))
                .addButton(self.setToMerch())
        }
    }
}