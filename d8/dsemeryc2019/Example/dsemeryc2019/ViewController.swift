//
//  ViewController.swift
//  dsemeryc2019
//
//  Created by denis_semerych@icloud.com on 04/11/2019.
//  Copyright (c) 2019 denis_semerych@icloud.com. All rights reserved.
//

import UIKit
import dsemeryc2019

class ViewController: UIViewController {

    
    let manager = ArticleManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = manager.newArticle(whithTitle: "Test", content: "Testing ", creationDate: NSDate(timeIntervalSince1970: 200521231512.2))
        if #available(iOS 10.0, *) {
            let articles = manager.getAllArticles()
            for article in articles {
                print(article.description)
            }
        } else {}
        test.language = "English"
        manager.save()
        if #available(iOS 10.0, *) {
            let articles = manager.getArticles(whithLang: "English")
            for article in articles {
                print("English")
                print(article.description)
            }
        }
        if #available(iOS 10.0, *) {
            let articles = manager.getArticles(whithLang: "English")
            for article in articles {
                print("English")
                print(article.description)
            }
        }
        if #available(iOS 10.0, *) {
            let articles = manager.getArticles(containString: "Test")
            print("string include")
            for article in articles {
                print("English")
                print(article.description)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

