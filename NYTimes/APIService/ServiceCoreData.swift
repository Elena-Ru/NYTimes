//
//  ServiceCoreData.swift
//  NYTimes
//
//  Created by Елена Русских on 20.11.2022.
//

import UIKit
import CoreData
import SDWebImage

class ServiceCD {

    static let shared  = ServiceCD()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var articles : [Article]?
    var news : [News]?
    
    private init(){}
    
    func fetchArticle() -> [News]? {
        do {
            articles =  try context.fetch(Article.fetchRequest())
            guard self.articles != nil else { return nil }
            news = transfomArticleToNews(articles: self.articles!)
        } catch {
            print(error)
        }
        return news
    }
    
  private func transfomArticleToNews( articles: [Article]) -> [News] {
        var news = [News]()
        articles.forEach {
            var newsItem = News()
            newsItem.id = Int($0.id)
            newsItem.url = $0.url
            newsItem.title = $0.title
            let imgData = $0.img
            let data = MediaMetadatum(image: imgData)
            var mediaData = [MediaMetadatum]()
            mediaData.append(data)
            var media = Media()
            media.mediaMetadata = mediaData
            var mediaAr = [Media]()
            mediaAr.append(media)
            newsItem.media = mediaAr
            news.append(newsItem)
        }
        return news
    }
        
    func fetchIsFav(id: Int) -> Bool {
        var isFavorite = false
        do {
            let request = Article.fetchRequest() as NSFetchRequest<Article>
            let pred = NSPredicate(format: "id CONTAINS '\(id)'")
            request.predicate = pred
            self.articles =  try context.fetch(request)
            if self.articles?.count ?? 0 > 0 {
                isFavorite = true
            }
        } catch {
            print(error.localizedDescription)
        }
        return isFavorite
    }
    
    func deleteFromCD(id: Int) {
        
        do {
            let request = Article.fetchRequest() as NSFetchRequest<Article>
            let pred = NSPredicate(format: "id CONTAINS '\(id)'")
            request.predicate = pred
            let articleToRemove =  try context.fetch(request)
            self.context.delete(articleToRemove.first!)
            try self.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveArticle(news: News) {
        
        let id = Int64(news.id!)
        let img = transformNewsToArticleImg(imgUrl: news.media?.first?.mediaMetadata?[0].url ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/New_York_Times_logo_variation.jpg/300px-New_York_Times_logo_variation.jpg")
        let article = Article(context: context)
        article.title = news.title
        article.img = img
        article.id = id
        article.url = news.url
        do {
             try  context.save()
        } catch {
            print(error)
        }
    }

    
    private func transformNewsToArticleImg(imgUrl: String) -> Data? {
        
        let image = UIImageView()
        image.sd_setImage(with: URL(string: imgUrl))
        let data = image.image?.jpegData(compressionQuality: 1.0)
        return data
    }
}
