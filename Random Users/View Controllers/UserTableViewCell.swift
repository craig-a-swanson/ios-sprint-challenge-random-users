//
//  UserTableViewCell.swift
//  Random Users
//
//  Created by Craig Swanson on 1/26/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var friendThumbnail: UIImage?
    var friend: Friend? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userThumbnailImage: UIImageView!
    

    // MARK: Methods
    func updateViews() {
        guard let friend = friend,
        let thumbnail = friendThumbnail else { return }
        
        userNameLabel.text = "\(friend.title) \(friend.first) \(friend.last)"
        userThumbnailImage.image = thumbnail
        }
}
