//
//  FilterViewController.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 13/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
    func applyFilters(filters: [String: String])
}

class FilterViewController: UIViewController {

    @IBOutlet weak var attributeTableView: UITableView!
    @IBOutlet weak var valueTableView: UITableView!
    
    weak var delegate: FilterViewControllerDelegate?
    private var viewModel = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupModel()
    }
    
    private func setupModel() {
        
        self.viewModel.attributesReloadHandler = {
            self.valueTableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                            at: .top,
                                            animated: false)
            self.attributeTableView.reloadData()
        }
        
        self.viewModel.valuesReloadHandler = {
            self.valueTableView.reloadData()
        }
        
        self.showLoader()
        self.viewModel.getFilters { (success) in
            self.hideLoader()
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        self.viewModel.clear()
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        self.delegate?.applyFilters(filters: self.viewModel.filters)
        self.navigationController?.popViewController(animated: true)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.attributeTableView.delegate = self
        self.attributeTableView.dataSource = self
        self.valueTableView.delegate = self
        self.valueTableView.dataSource = self
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
        switch tableView {
        case self.attributeTableView:
            return self.viewModel.attributesCount
        case self.valueTableView:
            return self.viewModel.valuesCount()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.attributeTableView:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FilterAttributeTableViewCell.defaultReuseIdentifier
            ) as! FilterAttributeTableViewCell
            cell.item = self.viewModel.item(at: indexPath.row)
            return cell
        case self.valueTableView:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FilterValueTableViewCell.defaultReuseIdentifier
            ) as! FilterValueTableViewCell
            cell.item = self.viewModel.value(at: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.attributeTableView:
            self.viewModel.didSelectAttribute(at: indexPath.row)
        case self.valueTableView:
            self.viewModel.didSelectValue(at: indexPath.row)
        default:
            break
        }
    }
    
}
