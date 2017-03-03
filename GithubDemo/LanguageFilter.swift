//
//  LanguageFilter.swift
//  GithubDemo
//
//  Created by Xie kesong on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import Foundation



struct LanguageFilter{
    struct Language{
        var name: String
        var isOn: Bool
    }
    
    lazy var filter = [Language]()
    
    init() {
        self.filter.append(Language(name: "Swift", isOn: false))
        self.filter.append(Language(name: "Objective-C", isOn: false))
        self.filter.append(Language(name: "Java", isOn: false))
        self.filter.append(Language(name: "Javascript", isOn: false))
        self.filter.append(Language(name: "Ruby", isOn: false))
        self.filter.append(Language(name: "Python", isOn: false))
    }

}
