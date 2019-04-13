//
//  AddingArticleViewController.swift
//  Diary
//
//  Created by Denis SEMERYCH on 13/04/2019.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import dsemeryc2019

class AddingArticleViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var content: UITextView!
    var imagePicker: UIImagePickerController!
    var article: Article?
    var articleManager: ArticleManager?
    @IBAction func takePicture(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func addPicture(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        content.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension AddingArticleViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        picture.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
   @objc func addArctile() {
    var deleteArticle: Article? = nil
    var creationDate: NSDate? = nil
    if let tmpArticle = self.article {
        creationDate = tmpArticle.creationDate
        articleManager?.removeArticle(article: tmpArticle)
        deleteArticle = tmpArticle
    }
    let article = articleManager?.newArticle(whithTitle: name.text!, content: content.text, creationDate: deleteArticle == nil ? Date() as NSDate : creationDate, modificationDate: deleteArticle != nil ?   Date() as NSDate : nil)
    if let picture = picture.image {article?.image = UIImagePNGRepresentation(picture)! as NSData}
    article?.language = Locale.current.languageCode
    articleManager?.save()
    self.navigationController?.popViewController(animated: true)
    }
}

extension AddingArticleViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
