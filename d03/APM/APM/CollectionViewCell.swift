//
//  CollectionViewCell.swift
//  APM
//
//  Created by Denis SEMERYCH on 4/4/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static var chekEnabled = 0
    
    static func disableNetworkActivity() {
        if chekEnabled == 4 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    @IBOutlet weak var processingDownload: UIActivityIndicatorView!
    @IBOutlet weak var cellImage: UIImageView!
}
