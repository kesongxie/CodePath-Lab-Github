//
//  LanCell.swift
//  GithubDemo
//
//  Created by Xie kesong on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class LanCell: UITableViewCell {
    
    @IBOutlet weak var languageLabel: UILabel!
    
    var language: LanguageFilter.Language!{
        didSet{
            self.languageLabel.text = self.language.name
            if self.language.isOn {
                self.accessoryType = .checkmark
            }else{
                self.accessoryType = .none

            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
