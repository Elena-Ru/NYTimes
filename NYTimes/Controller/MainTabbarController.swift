//
//  MainTabbarController.swift
//  NYTimes
//
//  Created by Елена Русских on 17.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    

    private func generateTabBar() {
        viewControllers = [
            generateVC(ApiRequestViewController(request: "emailed"), "Most Emailed", UIImage(systemName: "mail")),
            generateVC(ApiRequestViewController(request: "shared"), "Most Shared", UIImage(systemName: "square.and.arrow.up")),
            generateVC(ApiRequestViewController(request: "viewed"), "Most Viewed", UIImage(systemName: "eye")),
            generateVC(FavoriteViewController(), "Favorites", UIImage(systemName: "bookmark"))
        ].map{ UINavigationController(rootViewController: $0)}
    }
    
    private func generateVC(_ viewController: UIViewController, _ title: String, _ image: UIImage?) -> UIViewController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        viewController.navigationItem.title = title
        viewController.navigationItem.titleView = createCustomTitleView(contactName: title, contactImage: "logo")
        
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionX: CGFloat = 10.0
        let width = tabBar.bounds.width - positionX * 2
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.backgroundColor = #colorLiteral(red: 0.9616644979, green: 0.9566935897, blue: 0.9610925317, alpha: 1)
        
        tabBar.itemWidth = width / 6
        tabBar.itemPositioning = .centered
        tabBar.tintColor = UIColor.black
        tabBar.unselectedItemTintColor = UIColor.lightGray
    }
    
    func createCustomTitleView(contactName: String, contactImage: String) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 280, height: 41))
        
        let image = UIImageView()
        image.image = UIImage(named: contactImage)
        image.frame = CGRect(x: 5, y: 0, width: 34, height: 34)
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        view.addSubview(image)
        
        let mainLabel = UILabel()
        mainLabel.text = "The NY Times"
        mainLabel.frame = CGRect(x: 55, y: 10, width: 220, height: 20)
        mainLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(mainLabel)

        let label = UILabel()
        label.text = contactName
        label.frame = CGRect(x: 180, y: 11, width: 220, height: 20)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        view.addSubview(label)
        
        return view
    }
}
