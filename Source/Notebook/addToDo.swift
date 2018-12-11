//
//  addToDo.swift
//  Notebook
//
//  Created by Mai on 12/11/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit

class addToDo: UIViewController {

    //Mark : Outlet
    @IBOutlet weak var newToDo: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    //Mark : action
    @IBAction func save(_ sender: Any) {
        if newToDo?.text != ""{
             toDoList.append((newToDo?.text)!)
            newToDo?.text = ""
        }
       
    }
    
   
}
