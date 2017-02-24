//
//  ChatCellTableViewCell.swift
//  Parse Chat
//
//  Created by 蒋逍琦 on 2/23/17.
//  Copyright © 2017 蒋逍琦. All rights reserved.
//

import UIKit
import Parse

class ChatCellTableViewCell: UITableViewCell {

    @IBOutlet weak var messageField: UILabel!
    
    var myMessage: PFObject? {
        didSet {
            messageField.text = myMessage?["text"] as! String
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
