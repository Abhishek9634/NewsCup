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
    
    private var news: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        Headline.fetchParams { [weak self] (result) in
            switch result {
            case .success(let response):
                print(response)
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
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
