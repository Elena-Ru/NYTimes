//
//  FavoriteControl.swift
//  NYTimes
//
//  Created by Елена Русских on 21.11.2022.
//

import UIKit

class FavoriteControl: UIButton {
    
    let service = ServiceCD.shared
    private let rightInset: CGFloat = 25.0
    private let saveSize: CGFloat = 20.0
    var news: News?
    
    func setFavoriteButton(news: News? ) {
        self.news = news
        if self.service.fetchIsFav(id: (self.news?.id)!) {
                setFaveIcon()
            } else {
               setCommonIcon()
            }
            self.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.isUserInteractionEnabled = true
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if service.fetchIsFav(id: (news?.id)!) {
            setCommonIcon()
            service.deleteFromCD(id: (news?.id)!)
        } else {
           setFaveIcon()
            service.saveArticle(news: news!)
        }
    }
    
    private func setFaveIcon() {
        self.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        self.tintColor = .systemGray
    }
    
    private func setCommonIcon() {
        self.setImage(UIImage(systemName: "bookmark"), for: .normal)
        self.tintColor = .lightGray
    }
    
    func getFrameSave(width: CGFloat, height: CGFloat) {
        let saveControlSize = getShadowViewSize(side: saveSize)
        let saveControlX = width - saveSize - rightInset
        let saveControlY = (height - saveSize ) / 2
        let shadowViewOrigin = CGPoint(x: saveControlX , y: saveControlY)
        self.frame = CGRect(origin: shadowViewOrigin, size: saveControlSize)
    }
    
    func getShadowViewSize(side: CGFloat) -> CGSize {
        let size = CGSize(width: side, height: side)
        return size
    }
}
