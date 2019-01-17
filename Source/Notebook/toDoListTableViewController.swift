//
//  toDoListTableViewController.swift
//  Notebook
//
//  Created by Mai on 12/10/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit
import CoreData

 var toDoList = [String]()
class toDoListTableViewController: UITableViewController {

    //Mark : Outlet
    var resultsController: NSFetchedResultsController<TODO>!
    //var resultsController: NSFetchedResultsController<TODO>!

    
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Request
        let request: NSFetchRequest<TODO> = TODO.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "date", ascending: true)
        
        // Init
        request.sortDescriptors = [sortDescriptors]
        resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        resultsController.delegate = self as! NSFetchedResultsControllerDelegate
        
        // Fetch
        do {
            try resultsController.performFetch()
        } catch {
            print("Perform fetch error: \(error)")
        }
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }

    //Mark : Action
    @IBAction func addToDo(_ sender: Any) {
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
  
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return resultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! toDoListTableViewCell
       // cell.toDoLabel.text = toDoList[indexPath.row]
        
        
        let todo = resultsController.object(at: indexPath)
        cell.textLabel?.text = todo.title
        if(todo.priority == 1){
            self.myTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.green
        }
        else if (todo.priority == 2){
            self.myTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.blue
        }
     
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
    
    /*
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editButton = UITableViewRowAction(style: .normal, title: "Complete"){(rowAction,indexPath) in
            self.myTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.green
        }
        editButton.backgroundColor = UIColor.green
    
    let cancelButton = UITableViewRowAction(style: .destructive, title: "Delete"){(rowAction,indexPath) in
       
        self.myTableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        self.myTableView.endUpdates()
        }
          cancelButton.backgroundColor = UIColor.red
        
        let importantButton = UITableViewRowAction(style: .normal, title: "Important"){(rowAction,indexPath) in
            self.myTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.blue
        }
        importantButton.backgroundColor = UIColor.blue
    
        return [editButton, importantButton,cancelButton]
      }


    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           myTableView.beginUpdates()
           tableView.deleteRows(at: [indexPath], with: .fade)
            myTableView.endUpdates()
            
            myTableView.reloadData()
            
       }
    }'
*/
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowAddTodo", sender: tableView.cellForRow(at: indexPath))
    }
    
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let todo = self.resultsController.object(at: indexPath)
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            // TODO: Delete todo
            self.resultsController.managedObjectContext.delete(todo)
            do {
                try self.resultsController.managedObjectContext.save()
                completion(true)
            } catch {
                print("delete failed: \(error)")
                completion(false)
            }
        }
        action.backgroundColor = .red
        
        let action1 = UIContextualAction(style: .destructive, title: "Compelete") { (action, view, completion) in
            todo.priority = 1
            
            do {
                try context.save()
                
            } catch {
                print("Error saving todo: \(error)")
            }
            self.myTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.green
        }
        action1.backgroundColor = .green
        
        let action2 = UIContextualAction(style: .destructive, title: "Important") { (action, view, completion) in
            
            todo.priority = 2
            do {
                try context.save()
                
            } catch {
                print("Error saving todo: \(error)")
            }
            self.myTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.blue
            
        }
        action2.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [action,action1,action2])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = sender as? UIBarButtonItem, let vc = segue.destination as? AddNewTodoViewController {
            vc.managedContext = resultsController.managedObjectContext
            
        }
        
        if let cell = sender as? UITableViewCell, let vc = segue.destination as? AddNewTodoViewController {
            vc.managedContext = resultsController.managedObjectContext
            if let indexPath = tableView.indexPath(for: cell) {
                let todo = resultsController.object(at: indexPath)
                vc.todo = todo
            }
        }
    }
    

}



extension toDoListTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) {
                let todo = resultsController.object(at: indexPath)
                cell.textLabel?.text = todo.title
            }
        default:
            break
        }
    }
}









