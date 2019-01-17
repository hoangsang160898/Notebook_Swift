//
//  NoteTableViewController.swift
//  Notebook
//
//  Created by Mai on 12/9/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController, UISearchResultsUpdating{
    
   
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
//        print(searchController.searchBar.text!)
    }
    
    var searchController = UISearchController(searchResultsController: nil)

    var notes = [Note]()
    var filteredNotes = [Note]()
    var manageObjectContext: NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        //style :
        self.tableView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
      
        retrieveNotes()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        retrieveNotes()
    }

    // MARK: - Table view data source
    func setupNavbar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1.0)
     
        navigationItem.searchController = searchController
        if #available(iOS 11.0, *) {
            if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                if let backgroundview = textField.subviews.first {
                    backgroundview.backgroundColor = UIColor.white
                    backgroundview.layer.cornerRadius = 8;
                    backgroundview.clipsToBounds = true;
                }
            }
               searchController.obscuresBackgroundDuringPresentation = false
            navigationItem.searchController = searchController
          searchController.searchResultsUpdater = self
            navigationItem.hidesSearchBarWhenScrolling = true
            definesPresentationContext = true
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredNotes.count
        }
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTableViewCell", for: indexPath) as! noteTableViewCell
        let note : Note
        if isFiltering() {
            note = filteredNotes[indexPath.row]
        } else {
            note = notes[indexPath.row]
        }
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
            if !isFiltering(){

              
                //remove object from core data
                let context = manageObjectContext
                context.delete(notes[indexPath.row] as NSManagedObject)
                
                //update UI methods
                tableView.beginUpdates()
                notes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                appDelegate.saveContext()
            }else{
                
            }
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
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredNotes = notes.filter({( note : Note) -> Bool in
            return (note.noteName?.lowercased().contains(searchText.lowercased()))!
        })
        
        tableView.reloadData()
    }
}


