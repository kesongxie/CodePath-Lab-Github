//
//  GithubRepoSearchSettings.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

// Model class that represents the user's search settings
class GithubRepoSearchSettings {
    var searchString: String?
    var isFilterOn = false
    var minStars = 0
    lazy var lanFilter = LanguageFilter()
}
