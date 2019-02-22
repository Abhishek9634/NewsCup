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

class SourcesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disaposeBag = DisposeBag()
    
    var sources = PublishSubject<[Source]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setuptableView()
        self.fetchSources()
    }
    
    func setuptableView() {
        
        // SETUP CELL
        _ = self.sources.asObservable().bind(to: tableView.rx.items) { (tableView: UITableView,
                                                                        index: Int,
                                                                        element: Source) in
            let cell = SourceTableViewCell(style: .default,
                                           reuseIdentifier: SourceTableViewCell.defaultReuseIdentifier)
            cell.item = element
            return cell
        }
        
        // DID SELECT
        self.tableView.rx
            .modelSelected(Source.self)
            .subscribe(onNext: { model in
            print("\(model) was selected")
        }).disposed(by: self.disaposeBag)
        
        // RELOADING TABLE
        _ = self.sources.subscribe(onNext: {
            print("Publish Subject : \($0)")
            self.tableView.reloadData()
        }).disposed(by: self.disaposeBag)
    }

    func fetchSources() {
        self.showLoader()
        Source.fetchSources { [weak self] (result) in
            self?.hideLoader()
            switch result {
            case .success(let response):
                self?.sources.onNext(response.list)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
}
