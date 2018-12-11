//
//  toDoListTableViewController.swift
//  Notebook
//
//  Created by Mai on 12/10/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit

 var toDoList = [String]()
class toDoListTableViewController: UITableViewController {

    //Mark : Outlet
   
    
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }

    //Mark : Action
    @IBAction func addToDo(_ sender: Any) {
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
  
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! toDoListTableViewCell
        cell.toDoLabel.text = toDoList[indexPath.row]
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editButton = UITableViewRowAction(style: .normal, title: "Complete"){(rowAction,indexpath) in
            self.myTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.green
        }
        editButton.backgroundColor = UIColor.blue
        
    let cancelButton = UITableViewRowAction(style: .normal, title: "Cancel"){(rowAction,indexpath) in
        
        }
          cancelButton.backgroundColor = UIColor.yellow
        
        let importantButton = UITableViewRowAction(style: .normal, title: "Important"){(rowAction,indexpath) in
            self.myTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.red
        }
        cancelButton.backgroundColor = UIColor.red
    
        return [editButton, importantButton,cancelButton]
      }



    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
           tableView.deleteRows(at: [indexPath], with: .fade)
            myTableView.reloadData()
            
       }
    }

}
    

