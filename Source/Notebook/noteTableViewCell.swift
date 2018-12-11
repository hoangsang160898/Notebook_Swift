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
        shadowView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        shadowView.layer.shadowRadius = 1.5
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.cornerRadius = 2
        noteImageView.layer.cornerRadius = 2
        
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
