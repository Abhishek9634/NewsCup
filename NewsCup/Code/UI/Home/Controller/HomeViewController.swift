//
//  HomeViewController.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 12/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import Model

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var news: [TopNewsCellModel] = []
    private var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupSearchController()
        self.fetchNews()
//        Headline.fetchParams { [weak self] (result) in
//            switch result {
//            case .success(let response):
//                print(response)
//            case .failure(let error):
//                self?.handle(error: error)
//            }
//        }
    }
    
    private func fetchNews() {
        self.showLoader()
        Headline.fetchTopHeadlines(categories: ["general"],
                                   countries: ["us"]) { [weak self] (result) in
            self?.hideLoader()
            switch result {
            case .success(let response):
                self?.news = response.list.map {
                    TopNewsCellModel(article: $0)
                }
                self?.tableView.reloadData()
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TopNewsTableViewCell.defaultNib,
                                forCellReuseIdentifier: TopNewsTableViewCell.defaultReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TopNewsTableViewCell.defaultReuseIdentifier
        ) as! TopNewsTableViewCell
        cell.item = self.news[indexPath.row]
        return cell
    }
    
}

extension HomeViewController: UISearchResultsUpdating {
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text,
//            !text.isEmpty else { return }
//        self.tableView.reloadData()
    }
    
}
