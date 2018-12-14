//
//  NewsDetailViewController.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 14/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import SafariServices

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var news: TopNewsCellModel!
    private var cellItems: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupModel()
    }
    
    private func setupModel() {
        let titleModel = NewsDetailTitleCellModel(title: self.news.article.title,
                                                  date: self.news.date,
                                                  source: self.news.article.sourceName,
                                                  imageUrl: self.news.article.imageUrl)
        
        let descModel = NewsDetailDescriptionCellModel(title: "Description",
                                                       content: self.news.article.desc)
        
        let contentModel = NewsDetailDescriptionCellModel(title: "Content",
                                                          content: self.news.article.content)
        
        let webModel = NewsWebCellModel(webUrl: self.news.article.url)
        
        self.cellItems = [titleModel, descModel, contentModel, webModel]
        self.tableView.reloadData()
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        return self.cellItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reusableId = self.reusableId(indexPath) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reusableId
        ) as! TableViewCell
        cell.item = self.cellItems[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    private func reusableId(_ indexPath: IndexPath) -> String? {
        let model = self.cellItems[indexPath.row]
        switch model {
        case _ as NewsDetailTitleCellModel:
            return NewsDetailTitleTableViewCell.defaultReuseIdentifier
        case _ as NewsDetailDescriptionCellModel:
            return NewsDetailDescriptionTableViewCell.defaultReuseIdentifier
        case _ as NewsWebCellModel:
            return NewsWebTableViewCell.defaultReuseIdentifier
        default:
            return nil
        }
    }
}

extension NewsDetailViewController: NewsWebTableViewCellDelegate {
    
    func handleWebAction(_ cell: NewsWebTableViewCell, url: String) {
        guard let webUrl = URL(string: url) else { return }
        let svc = SFSafariViewController(url: webUrl)
        self.present(svc, animated: true, completion: nil)
    }
}
