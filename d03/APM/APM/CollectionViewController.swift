//
//  CollectionViewController.swift
//  APM
//
//  Created by Denis SEMERYCH on 4/4/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var data = ImageData()
    

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        cell.processingDownload.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        cell.backgroundColor = UIColor.black
        downloadDataFromURL(indexPath: indexPath, url: data.urls[indexPath.row]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToImage", sender: collectionView.cellForItem(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ScrollViewController
        destVC.navigationItem.title = "Selected Image"
        let cell = sender as! CollectionViewCell
        destVC.passedImage = cell.cellImage.image
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func disableActivityIndicator(forCellAtIndexPath indexPath: IndexPath) {
        let cell = imageCollectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.processingDownload.stopAnimating()
    }
    
    func  downloadDataFromURL(indexPath: IndexPath, url: URL) {
        getData(from: url) {data, response, error in
            guard let data = data, error == nil else {
                let alert = UIAlertController(title: "Error in downloading image from url: ", message: url.description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:{action in self.disableActivityIndicator(forCellAtIndexPath: indexPath)}))
                self.present(alert, animated: true)
                CollectionViewCell.chekEnabled += 1
                return
            }
            DispatchQueue.main.async {
                let cell = self.imageCollectionView.cellForItem(at: indexPath) as! CollectionViewCell
                let image = UIImage(data: data)
                cell.cellImage.image = image
                cell.processingDownload.isHidden = true
                CollectionViewCell.chekEnabled += 1
                CollectionViewCell.disableNetworkActivity()
            }
        }
    }
}
