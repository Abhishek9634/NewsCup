//
//  SourceHeadlinesViewController.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 23/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Model

class SourceHeadlinesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disaposeBag = DisposeBag()
    private var news = BehaviorRelay<[TopNewsCellModel]>(value: [])
    private var currentPage: Int = 0
    var source: String!
    
    private struct Segue {
        static let NewsDetail = "SourceTopNewsDetailViewSegueId"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.fetchNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchNews() {
        self.showLoader()
        Source.sourceTopHeadlines(for: self.source) { [weak self] (result) in
         self?.hideLoader()
            switch result {
            case .success(let response):
                let news = response.list.map { TopNewsCellModel(article: $0) }
                self?.news.accept(news)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
}

extension SourceHeadlinesViewController {
    
    private func setupView() {
        
        // DISBALE LARGE TILE
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        
        // REGISTER CELL
        self.tableView.register(TopNewsTableViewCell.defaultNib,
                                forCellReuseIdentifier: TopNewsTableViewCell.defaultReuseIdentifier)
        
        
        // SETUP CELL
        _ = self.news.bind(to: self.tableView.rx.items(
                cellIdentifier: TopNewsTableViewCell.defaultReuseIdentifier,
                cellType: TopNewsTableViewCell.self)
        ) { row, element, cell in
            cell.item = element
        }
        
        
        // DID SELECT
        self.tableView.rx
            .modelSelected(TopNewsCellModel.self)
            .subscribe(onNext: { model in
                print("\(model) was selected")
                self.performSegue(withIdentifier: Segue.NewsDetail, sender: model)
            }).disposed(by: self.disaposeBag)
        
        
        // RELOADING TABLE
        _ = self.news.subscribe(onNext: {
            print("Behaviour Relay: \($0)")
            self.tableView.reloadData()
        }).disposed(by: self.disaposeBag)
        
    }

}

extension SourceHeadlinesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination, sender) {
        case (Segue.NewsDetail,
              let vc as NewsDetailViewController,
              let model as TopNewsCellModel):
            vc.news = model
        default:
            break
        }
        super.prepare(for: segue, sender: sender)
    }
    
}
