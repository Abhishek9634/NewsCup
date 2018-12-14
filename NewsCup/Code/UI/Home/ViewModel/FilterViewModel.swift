//
//  FilterViewModel.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 13/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import Model

protocol FilterValue: class {
    var value: String { get set }
    var isSelected: Bool { get set }
}

class FilterCategory: FilterValue {
    
    var value: String
    var isSelected: Bool
    
    init(title: String,
         isSelected: Bool = false) {
        self.value = title
        self.isSelected = isSelected
    }
}

class FilterCountry: FilterValue {
    
    var value: String
    var isSelected: Bool
    
    init(code: String,
         isSelected: Bool = false) {
        self.value = code
        self.isSelected = isSelected
    }
}

class FilterModel {
    
    var attribute: String
    var values: [FilterValue]
    var isSelected: Bool
    
    init(attribute: String,
         values: [FilterValue],
         isSelected: Bool = false) {
        self.attribute = attribute
        self.values = values
        self.isSelected = isSelected
    }
}

typealias FilterViewModelReloadHandler = () -> Void

class FilterViewModel {
    
    private var items: [FilterModel] = []
    var attributesReloadHandler: FilterViewModelReloadHandler = { }
    var valuesReloadHandler: FilterViewModelReloadHandler = { }
    var filters: [String: String] = [:]
    
    init() { }
    
    func getFilters(completion: @escaping (_ success: Bool) -> Void) {
        Headline.fetchParams { (result) in
            switch result {
            case .success(let param):
                self.setupData(param)
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    private func setupData(_ param: HeadlinesRequestParam) {
        
        let categories = param.categories.map {
            FilterCategory(title: $0)
        }
        
        let countries = param.countries.map {
            FilterCountry(code: $0.code)
        }
        
        self.items = [FilterModel(attribute: "Category", values: categories, isSelected: true),
                      FilterModel(attribute: "Country", values: countries)]
        
        self.reloadAll()
    }
}

extension FilterViewModel {
    
    func reloadAll() {
        self.valuesReloadHandler()
        self.attributesReloadHandler()
    }
    
    var attributesCount: Int {
        return self.items.count
    }
    
    func valuesCount(for attribute: String) -> Int {
        guard let index = self.items.index(where: {
            $0.attribute == attribute
        }) else { return 0 }
        return self.items[index].values.count
    }
    
    func item(at index: Int) -> FilterModel {
        return self.items[index]
    }
    
    var currentAttributeIndex: Int {
        guard let index = self.items.index (where: {
            $0.isSelected == true
        }) else {
            return 0
        }
        return index
    }
    
    // VALUES COUNT AT CURRENT INDEX aka SELECTED INDEX
    func valuesCount() -> Int {
        let model = self.items[self.currentAttributeIndex]
        return model.values.count
    }
    
    func value(at index: Int) -> FilterValue {
        let model = self.items[self.currentAttributeIndex]
        return model.values[index]
    }
    
    func clear() {
        self.filters.removeAll()
        self.items.forEach { model in
            model.isSelected = false
            model.values.forEach { $0.isSelected = false }
        }
        self.reloadAll()
    }
    
    func didSelectAttribute(at index: Int) {
        self.items.forEach { $0.isSelected = false }
        self.items[index].isSelected = true
        self.reloadAll()
    }
    
    func didSelectValue(at index: Int) {
        let model = self.items[self.currentAttributeIndex]
        model.values.forEach { $0.isSelected = false }
        model.values[index].isSelected = true
        
        // HANDLE FILTERS
        self.filters[model.attribute] = model.values[index].value
        
        // RELOAD
        self.valuesReloadHandler()
    }
    
}
