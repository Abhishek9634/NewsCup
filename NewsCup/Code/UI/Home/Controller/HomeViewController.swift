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
    private var filters: [String: String] = [:]
    private var currentPage: Int = 0
    
    private struct Segue {
        static let Filter = "FilterViewSegueId"
        static let NewsDeatil = "TopNewsDetailViewSegueId"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupSearchController()
        self.fetchNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func filterAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: Segue.Filter, sender: nil)
    }
    
    private func fetchNews() {
        
        var categories: [String] = ["general"]
        var countries: [String] = ["us"]
        
        if let category = self.filters["Category"] {
            categories = [category]
        }
        
        if let country = self.filters["Country"] {
            countries = [country]
        }
        
        self.showLoader()
        Article.fetchTopHeadlines(categories: categories,
                                   countries: countries) { [weak self] (result) in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.news[indexPath.row]
        self.performSegue(withIdentifier: Segue.NewsDeatil, sender: model)
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

extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination, sender) {
        case (Segue.Filter, let vc as FilterViewController, _):
            vc.delegate = self
        case (Segue.NewsDeatil,
              let vc as NewsDetailViewController,
              let model as TopNewsCellModel):
            vc.news = model
        default:
            break
        }
        super.prepare(for: segue, sender: sender)
    }
}

extension HomeViewController: FilterViewControllerDelegate {
    
    func applyFilters(filters: [String: String]) {
        if !self.news.isEmpty {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                       at: .top,
                                       animated: false)
        }
        
        self.filters = filters
        self.fetchNews()
    }
}
