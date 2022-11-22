//
//  FavoriteViewController.swift
//  NYTimes
//
//  Created by Елена Русских on 17.11.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    let apiService = ApiService.shared
    let service = ServiceCD.shared

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NYTimesTableViewCell.self, forCellReuseIdentifier: NYTimesTableViewCell.identifier)
        return tableView
    }()

    var news : [News]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        news = self.service.fetchArticle()
        tableView.reloadData()
    
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: NYTimesTableViewCell.identifier, for: indexPath) as? NYTimesTableViewCell else { return UITableViewCell()}
        
        cell.news = news?[indexPath.row]
        let text = cell.news?.title ?? "NOT FOUND"
        var image = UIImage()
        if let data = cell.news?.media?.first?.mediaMetadata?[0].image {
            image = UIImage(data: data)!
        }
        cell.configure(text: text, imageCD: image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Creat new VC")
        let secondVC = DetailViewController()
        secondVC.article = news?[indexPath.row].url
        navigationController?.pushViewController(secondVC, animated: true)
      
    }

}
