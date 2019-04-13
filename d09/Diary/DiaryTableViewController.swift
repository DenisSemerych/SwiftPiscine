//
//  DiaryTableViewController.swift
//  Diary
//
//  Created by Denis SEMERYCH on 13/04/2019.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import dsemeryc2019

class DiaryTableViewController: UITableViewController {

var articleManager = ArticleManager()
var articles = [Article]()

override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self

}

override func viewWillAppear(_ animated: Bool) {
    articles = articleManager.getArticles(whithLang: Locale.current.languageCode!)
    DispatchQueue.global(qos: .background).sync {
        tableView.reloadData()
    }
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryCell
    cell.title.text = articles[indexPath.row].title
    if let image = articles[indexPath.row].image {cell.photo.image = UIImage(data: image as Data)}
    cell.content.text = articles[indexPath.row].content
    cell.currentDate.text = "\(String(describing: articles[indexPath.row].creationDate?.description)) Modifite: \(String(describing: articles[indexPath.row].modificationDate?.description))"
    return cell
}

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToAdding", sender: indexPath)
}

override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {action, index in
        let article = self.articles[indexPath.row]
        self.articleManager.removeArticle(article: article)
    }
    return [delete]
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destVC = segue.destination as! AddingArticleViewController
    destVC.articleManager = articleManager
    destVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Article", style: .done, target: destVC, action: #selector(destVC.addArctile))
    if segue.identifier == "goToAdding", let index = sender as? IndexPath {
        destVC.article = articles[index.row]
    }
}
}
