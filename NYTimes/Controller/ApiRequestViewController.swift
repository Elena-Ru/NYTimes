//
//  MostEmailedViewController.swift
//  NYTimes
//
//  Created by Елена Русских on 17.11.2022.
//

import UIKit
import FirebaseAuth

class ApiRequestViewController: UIViewController {
    
    let apiService = ApiService.shared
    
    var news = [News]()
    
    let logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        return button
    }()

    @objc func logout() {
        print(1)
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NYTimesTableViewCell.self, forCellReuseIdentifier: NYTimesTableViewCell.identifier)
        return tableView
    }()
    var requestType: String

    init(request: String) {
          self.requestType = request
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 5.0
        view.addSubview(tableView)
        self.navigationItem.setLeftBarButton(logoutButton, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        apiService.fetchData(type: requestType) { news in
            guard let news = news else { return }
            self.news = news
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ApiRequestViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: NYTimesTableViewCell.identifier, for: indexPath) as? NYTimesTableViewCell else { return UITableViewCell()}
        cell.news = news[indexPath.row]
        let text = cell.news?.title ?? "NOT FOUND"
        let url = URL(string: cell.news?.media?.first?.mediaMetadata?[0].url ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/New_York_Times_logo_variation.jpg/300px-New_York_Times_logo_variation.jpg")!
        cell.configure(text: text, urlImage: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondVC = DetailViewController()
        secondVC.article = news[indexPath.row].url
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

