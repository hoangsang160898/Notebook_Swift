//
//  noteTableViewCell.swift
//  Notebook
//
//  Created by Mai on 12/9/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteNameLabel: UILabel!
    @IBOutlet weak var noteDiscriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        noteImageView.image=UIImage(named: "ImageTest")
        
        //style :
        noteImageView.layer.cornerRadius = 32
        noteImageView.layer.masksToBounds = true
        shadowView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.cornerRadius = 10
     
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configueCell(note : Note ){
        self.noteNameLabel.text = note.noteName?.uppercased()
        self.noteDiscriptionLabel.text = note.noteDiscription
        self.noteImageView.image = UIImage(data: note.noteImage! as Data)
        
    }

}
