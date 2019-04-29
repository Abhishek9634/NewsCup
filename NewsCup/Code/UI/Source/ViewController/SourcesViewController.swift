//
//  SourcesViewController.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 21/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Model
import SafariServices

class SourcesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var paginationManager: PaginationUIManager?
    private var isDragging: Bool {
        return self.tableView.isDragging
    }
    
    let disaposeBag = DisposeBag()
    
    var sources = BehaviorRelay<[Source]>(value: [])
    
    private struct Segue {
        static let NewsList = "SourceTopNewsViewSegueId"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setuptableView()
        self.setupPagination()
        self.fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setuptableView() {
        
        // REGISTER CELL
        self.tableView.register(SourceTableViewCell.defaultNib,
                                forCellReuseIdentifier: SourceTableViewCell.defaultReuseIdentifier)
        
        
        // SETUP CELL
        _ = self.sources.bind(to: self.tableView.rx.items(cellIdentifier: SourceTableViewCell.defaultReuseIdentifier,
                                                          cellType: SourceTableViewCell.self)) { row, element, cell in
            cell.item = element
        }
        
        
        // DID SELECT
        self.tableView.rx
            .modelSelected(Source.self)
            .subscribe(onNext: { model in
            print("\(model) was selected")
            self.performSegue(withIdentifier: Segue.NewsList, sender: model)
        }).disposed(by: self.disaposeBag)
        
        
        
        // RELOADING TABLE
        _ = self.sources.subscribe(onNext: {
            print("Behaviour Relay: \($0.count)")
            self.tableView.reloadData()
        }).disposed(by: self.disaposeBag)
        
    }

    func fetchSources() {
        self.showLoader()
        Source.fetchSources { [weak self] (result) in
            self?.hideLoader()
            switch result {
            case .success(let response):
                self?.sources.accept(response.list)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    func rxfetchSources(completion: @escaping (Bool) -> Void) {
        if !self.isDragging { self.showLoader() }
        let observable = Source.fetchSources()
        _ = observable.subscribe( { [weak self] (element) in
            self?.hideLoader()
            switch element {
            case .next(let list):
                self?.sources.accept(list)
            case .error(let error):
                self?.handle(error: AppError.customER(error: error as! ErrorResponse))
            default:
                break
            }
            completion(true)
        }).disposed(by: self.disaposeBag)
    }
    
    func loadMore(list: [Source]) {
//        CASE LOAD MORE IN BEHAVIOUR RELAY
//        var items = self.sources.value
//        items.append(contentsOf: list)
//        self.sources.accept(items)
    }
    
}

extension SourcesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination, sender) {
        case (Segue.NewsList,
              let vc as SourceHeadlinesViewController,
              let model as Source):
            vc.source = model.id
        default:
            break
        }
        super.prepare(for: segue, sender: sender)
    }
    
}

extension SourcesViewController: PaginationUIManagerDelegate {
    
    private func setupPagination() {
        self.paginationManager = PaginationUIManager(scrollView: self.tableView)
        self.paginationManager?.delegate = self
    }
    
    private func fetchItems() {
        self.paginationManager?.load { }
    }
    
    func refreshAll(completion: @escaping (_ hasMoreData: Bool) -> Void) {
        self.rxfetchSources(completion: completion)
    }
    
    func loadMore(completion: @escaping (_ hasMoreData: Bool) -> Void) {
        completion(false)
    }
    
}
