//
//  JSQViewController.swift
//  Siri
//
//  Created by Denis SEMERYCH on 4/10/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class JSQViewController: JSQMessagesViewController {
    
    var messages = [Message]()
    var avatars: JSQMessageAvatarImageDataSource
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    

}


extension JSQViewController  {
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        if messages[indexPath.row].senderId == "1" {
        }
    }
}
