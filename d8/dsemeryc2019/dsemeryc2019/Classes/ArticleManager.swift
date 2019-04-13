//
//  ArticleManager.swift
//  
//
//  Created by Denis SEMERYCH on 4/11/19.
//

import Foundation
import CoreData


public class ArticleManager {
   

    private var managedObjectContext: NSManagedObjectContext?
    
    public init() {
        guard let modelURL = Bundle.init(for: Article.self).url(forResource: "article", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext!.persistentStoreCoordinator = psc
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Unable to resolve document directory")
            }
            let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
   public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ArticleManager {
    
    public func newArticle(whithTitle title: String, content: String, creationDate: NSDate) -> Article {
        let article = NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext!) as! Article
        article.content = content
        article.creationDate = creationDate
        article.title = title
        managedObjectContext?.insert(article)
        do {
            try managedObjectContext?.save()
            }
            catch {
                fatalError("Error saving data")
            }
        return article
    }
    
    @available(iOS 10.0, *)
    public func getAllArticles() -> [Article] {
        var articles: [Article]
        do {
            let result = try managedObjectContext?.fetch(Article.fetchRequest())
            articles = result as! [Article]
        }
        catch {
            fatalError("Error in requesting files")
        }
        return articles
    }
    
    @available(iOS 10.0, *)
    public func getArticles(whithLang lang: String) -> [Article] {
        let articles = self.getAllArticles()
        let langArticles = articles.filter{$0.language == lang}
        return langArticles
    }
    @available(iOS 10.0, *)
    public func getArticles(containString str: String) -> [Article] {
        let articles = self.getAllArticles()
        let result = articles.filter{($0.title?.contains(str))! || ($0.content?.contains(str))!}
        return result
    }
    public func removeArticle(article: Article) {
        managedObjectContext?.delete(article)
        do {
            try managedObjectContext?.save()
        }
        catch {
            fatalError("Error in saving after deleting article")
        }
    }
    
    public func save() {
        do {
            try managedObjectContext?.save()
        }
        catch {
            fatalError("Error in function save()")
        }
    }
}
