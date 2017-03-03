//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Xie kesong on 2/28/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

protocol SearchSettingsTableViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}

fileprivate let reuseIden = "LanCell"

class SearchSettingsTableViewController: UITableViewController {
    @IBOutlet weak var slider: UISlider!{
        didSet{
            self.slider.value = Float(self.searchSettings.minStars)
        }
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.minStarLabel?.text = String(Int(sender.value))
    }
    @IBOutlet weak var minStarLabel: UILabel!{
        didSet{
            self.minStarLabel.text = String(self.searchSettings.minStars)
        }
    }
    
    
    @IBAction func cancelBtnTapped(_ sender: UIBarButtonItem) {
        delegate?.didCancelSettings()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
        if let setting = searchSettings{
            self.searchSettings.isFilterOn = self.languageFilterSwitch.isOn
            self.searchSettings.minStars = Int(self.slider.value)
            self.searchSettings.lanFilter = self.lanFilter
            delegate?.didSaveSettings(settings: setting)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var languageFilterSwitch: UISwitch!{
        didSet{
            self.languageFilterSwitch.isOn = self.isLanFilterOn
        }
    }
    
    @IBAction func switchDidToggleed(_ sender: UISwitch) {
        self.isLanFilterOn = sender.isOn
        self.tableView.reloadData()
    }
    
    
    var searchSettings:GithubRepoSearchSettings!{
        didSet{
            self.isLanFilterOn = self.searchSettings.isFilterOn
            self.languageFilterSwitch?.isOn = self.isLanFilterOn
            self.lanFilter = self.searchSettings.lanFilter
            self.minStarLabel?.text = String(self.searchSettings.minStars)
            self.slider?.value = Float(self.searchSettings.minStars)
        }
    }

    //temp lan filter
    var lanFilter: LanguageFilter!
    
    //isFilterOn
    var isLanFilterOn: Bool = false
    
    
    weak var delegate: SearchSettingsTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.isLanFilterOn ? self.lanFilter.filter.count : 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIden, for: indexPath) as! LanCell
        cell.language = self.lanFilter.filter[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let isOn = self.lanFilter.filter[indexPath.row].isOn
        cell?.accessoryType = isOn ? .none : .checkmark
        self.lanFilter.filter[indexPath.row].isOn = !isOn
    }
    
}


