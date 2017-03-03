//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

fileprivate let reuseIden = "RepoCell"
fileprivate let PresentSettingsSegueIden = "PresentSettingsSegue"

// Main ViewController
class RepoResultsViewController: UIViewController {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //set up tablview view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        self.searchBar = UISearchBar()
        self.searchBar.delegate = self
        self.searchBar.enablesReturnKeyAutomatically = false


        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        self.navigationItem.titleView = self.searchBar

        // Perform the first search when the view controller first loads
        self.doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {
        if !self.isSearching{
            MBProgressHUD.showAdded(to: self.view, animated: true)
            // Perform request to GitHub API to get the list of repositories
            self.isSearching = true
            GithubRepo.fetchRepos(self.searchSettings, successCallback: { (newRepos) -> Void in
                self.repos = newRepos
                self.isSearching = false
                MBProgressHUD.hide(for: self.view, animated: true)
                }, error: { (error) -> Void in
                    if error != nil{
                        print(error!.localizedDescription)
                    }
            })
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let iden = segue.identifier, iden == PresentSettingsSegueIden{
            if let nvc = segue.destination as? UINavigationController{
                if let searchSettingsTVC = nvc.viewControllers.first as? SearchSettingsTableViewController{
                    searchSettingsTVC.delegate = self
                    searchSettingsTVC.searchSettings = self.searchSettings
                }
            }
        }
    }
    
    
    
    
    
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.doSearch()

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        self.doSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchSettings.searchString = searchBar.text
        self.doSearch()

    }
}


extension RepoResultsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIden, for: indexPath) as!RepoTableViewCell
        cell.selectionStyle = .none
        cell.repo = self.repos![indexPath.row]
        return cell
    }
}


extension RepoResultsViewController: SearchSettingsTableViewControllerDelegate{
    func didSaveSettings(settings: GithubRepoSearchSettings) {
        self.searchSettings = settings
        //update the search
        self.doSearch()
    }
    
    func didCancelSettings() {
        print("cancel")
    }
  
}
