//
//  toDoListTableViewCell.swift
//  Notebook
//
//  Created by Mai on 12/11/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit

class toDoListTableViewCell: UITableViewCell {

    //MARK : Outlet
    @IBOutlet weak var toDoLabel: UILabel!
    var complete = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
