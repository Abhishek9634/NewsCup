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
    
    let disaposeBag = DisposeBag()
    
    var sources = PublishSubject<[Source]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setuptableView()
        self.fetchSources()
    }
    
    func setuptableView() {
        
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
            self.openSafari(urlString: model.url)
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
    
    func openSafari(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }
    
}
