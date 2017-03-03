//
//  RepoTableViewCell.swift
//  GithubDemo
//
//  Created by Xie kesong on 1/28/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var avatorImageView: UIImageView!{
        didSet{
            self.avatorImageView.layer.cornerRadius = 4.0
            self.avatorImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var starCountBtn: UIButton!
    
    @IBOutlet weak var forkCountBtn: UIButton!
    
    var repo: GithubRepo!{
        didSet{
            self.avatorImageView.image = nil
            if let urlString = self.repo.ownerAvatarURL, let url = URL(string: urlString){
                self.avatorImageView.setImageWith(url)
            }
            self.repoTitleLabel.text = self.repo.name
            if let ownerName = self.repo.ownerHandle{
                self.authorLabel.text = "by " + ownerName
            }
            self.repoDescriptionLabel.text = self.repo.repoDescription
            if let startCount = self.repo.stars{
                self.starCountBtn.setTitle(String(startCount), for: .normal)
            }
            if let forkCount = self.repo.forks{
                self.forkCountBtn.setTitle(String(forkCount), for: .normal)
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
