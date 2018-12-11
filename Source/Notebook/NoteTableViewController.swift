//
//  NoteTableViewController.swift
//  Notebook
//
//  Created by Mai on 12/9/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController {

    var notes = [Note]()
    var manageObjectContext: NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //style :
        self.tableView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveNotes()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTableViewCell", for: indexPath) as! noteTableViewCell
        let note: Note = notes[indexPath.row]
        cell.configueCell(note : note)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 

 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        
            //remove object from core data
            let context = manageObjectContext
            context.delete(notes[indexPath.row] as NSManagedObject)
            
            //update UI methods
            tableView.beginUpdates()
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            appDelegate.saveContext()
            
        }
        
    }
    
    func retrieveNotes(){
        manageObjectContext.perform {
            self.fetchNoteFromCoreData {(notes) in
                if let notes = notes {
                   self.notes = notes
                self.tableView.reloadData()
               }
            }
        }
    }
    
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let sb = UIStoryboard(name:"Main", bundle:nil)
       let mh2 = sb.instantiateViewController(withIdentifier: "NoteDetail") as! ViewController
       mh2.note = notes[indexPath.row]
       self.navigationController?.pushViewController(mh2, animated: true)
   }
    
    func fetchNoteFromCoreData(completion : @escaping ([Note]?) -> Void ){
        manageObjectContext.perform {
            var notes = [Note]()
            let request : NSFetchRequest<Note> = Note.fetchRequest()
            
            do{
                notes = try self.manageObjectContext.fetch(request)
                completion(notes)
            }
            catch{
                print("can not fetch ")
            }
        }
    }
  
}
