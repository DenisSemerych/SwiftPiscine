//
//  ScrollViewController.swift
//  APM
//
//  Created by Denis SEMERYCH on 4/4/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var image: UIImageView!
    var passedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        let screenSize = UIScreen.main.bounds
        image.frame = screenSize
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        image.image = passedImage
        if let size = passedImage?.size {
            scrollView.contentSize = size
        }
        scrollView.maximumZoomScale = 4.0
        scrollView.directionalPressGestureRecognizer.isEnabled = true
        scrollView.backgroundColor = UIColor.white
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
