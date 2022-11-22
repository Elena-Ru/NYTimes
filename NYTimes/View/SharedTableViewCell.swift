//
//  SharedTableViewCell.swift
//  NYTimes
//
//  Created by Елена Русских on 19.11.2022.
//

import UIKit
import SDWebImage


class NYTimesTableViewCell: UITableViewCell {
    
    let service = ServiceCD.shared

static let identifier = "cell"
    
    private let sideShadowView: CGFloat = 80.0
    private let leftInset: CGFloat = 10.0
    private let rightInset: CGFloat = 25.0
    private let distanceItems: CGFloat = 20.0
    private let saveSize: CGFloat = 20.0
   
    var news : News?
    
    private let shadowView: UIView = {
        
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 3, height: 1)
        v.layer.shadowOpacity = 0.7
        v.layer.shadowRadius = 10.0
        return v
    }()
    
    private var newsImageView: UIImageView = {
        
       let v = UIImageView()
       v.translatesAutoresizingMaskIntoConstraints = false
       v.layer.masksToBounds = true
       v.layer.cornerRadius = 20
       v.contentMode = .scaleAspectFill
       v.clipsToBounds = true
       return v
   }()
    
    private var titleLabel: UILabel = {
        
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        return v
    }()
    
    var saveControl =  FavoriteControl()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(shadowView)
        shadowView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(saveControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        getFrameShadowView()
        getFrameNewsImage()
        getFrameTitle()
        saveControl.getFrameSave(width: contentView.bounds.width, height: bounds.height)
    }
    
    func getShadowViewSize(side: CGFloat) -> CGSize {
        
        let size = CGSize(width: side, height: side)
        return size
    }
    
    func getFrameShadowView() {
        
        let shadowViewSize = getShadowViewSize(side: sideShadowView)
        let shadowViewOrigin = CGPoint(x: leftInset, y: leftInset)
        shadowView.frame = CGRect(origin: shadowViewOrigin, size: shadowViewSize)
    }
    
    func getFrameNewsImage() {
        
        let newsImageSize = getShadowViewSize(side: sideShadowView)
        let newsImageOrigin = CGPoint(x: 0, y: 0)
        newsImageView.frame = CGRect(origin: newsImageOrigin, size: newsImageSize)
    }
    
    func setNewsImageView(url: URL) {
        
        newsImageView.sd_setImage(with: url)
        getFrameNewsImage()
    }
    
    func setNewsImageCG(image: UIImage) {
        
        newsImageView.image = image
        getFrameNewsImage()
    }
    
    func getLabelSize(text: String, font: UIFont) -> CGSize {
        
        let maxWidth = contentView.bounds.width - leftInset - rightInset - sideShadowView - distanceItems * 2 - saveSize
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    func getFrameTitle() {
        
        let newsLabelSize = getLabelSize(text: titleLabel.text ?? "NOT FOUND", font: titleLabel.font)
        let newsLabelX = leftInset + sideShadowView + distanceItems
        let newsLabelY = (bounds.height - newsLabelSize.height) / 2
        let newsLabelOrigin = CGPoint(x: newsLabelX, y: newsLabelY)
        titleLabel.frame = CGRect(origin: newsLabelOrigin, size: newsLabelSize)
    }
    
    func setTitleLabel(text: String) {
        
        titleLabel.text = text
        getFrameTitle()
    }
    
    
    func configure(text: String, urlImage: URL? = nil, imageCD: UIImage? = nil) {
  
        if (urlImage != nil){
            setNewsImageView(url: urlImage!)
        } else {
            setNewsImageCG(image: imageCD!)
        }
        setTitleLabel(text: text)
        saveControl.setFavoriteButton(news: news!)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        newsImageView.image = nil
    }
    
}
