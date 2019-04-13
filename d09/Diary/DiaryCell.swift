//
//  DiaryCell.swift
//  Diary
//
//  Created by Denis SEMERYCH on 13/04/2019.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class DiaryCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var photo: UIImageView!
    
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var currentDate: UILabel!
    
}
