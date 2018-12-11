//
//  ViewController.swift
//  Notebook
//
//  Created by Sang Leo on 12/6/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate{

    @IBOutlet weak var noteInfoView: UITextView!
    @IBOutlet weak var noteImageViewView: UIView!
    @IBOutlet weak var noteNameLabel: UITextField!
    @IBOutlet weak var noteDiscriptionLabel: UITextView!
    @IBOutlet weak var noteImageView: UIImageView!
    
    
    
    var manageObjectContext : NSManagedObjectContext!{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    var notesFetchResultController : NSFetchedResultsController<Note>!
    var notes = [Note]()
    var note : Note?
    var isExisting = false
    var indexPath : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        noteImageView.image=UIImage(named: "ImageTest")
        
        // Load data
        if let note = note {
            noteNameLabel.text = note.noteName
            noteDiscriptionLabel.text = note.noteDiscription
            noteImageView.image = UIImage(data: note.noteImage! as Data)
        }
        
        if noteNameLabel.text != ""{
            isExisting = true
        }
        
        //delegate
        noteNameLabel.delegate = self
        noteDiscriptionLabel.delegate = self
        
        //style
        noteInfoView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        noteInfoView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        noteInfoView.layer.shadowRadius = 1.5
        noteInfoView.layer.shadowOpacity = 0.2
        noteInfoView.layer.cornerRadius = 2
        
        noteImageViewView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        noteImageViewView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        noteImageViewView.layer.shadowRadius = 1.5
        noteImageViewView.layer.shadowOpacity = 0.2
        noteImageViewView.layer.cornerRadius = 2
       
        noteNameLabel.setButtonBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    //core data
    func saveToCoreData(completion : @escaping()->Void){
        manageObjectContext.perform {
            do{
                try self.manageObjectContext.save()
                completion()
                print(" save to core data susscessful ")
            }
            catch let error{
                print("can not save to core Data : \(error.localizedDescription)")
            }
        }
    }
    
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.noteImageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickImageButtonWasPressed(_ sender: UITapGestureRecognizer) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let arlertController = UIAlertController(title: "Add an Image", message: "Choose from", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            (action ) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default){
            (action ) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let savePhotoAction = UIAlertAction(title: "Saved Photo Album", style: .default){
            (action ) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
//        arlertController.addAction(cameraAction)
        arlertController.addAction(photoLibraryAction)
        arlertController.addAction(savePhotoAction)
        arlertController.addAction(cancelAction)
        present(arlertController, animated: true, completion: nil)
        
    }
    
    // save
 
    @IBAction func saveButtonWasPressed(_ sender: Any) {
        
        if noteNameLabel.text == "" || noteNameLabel.text == "NOTE NAME" || noteDiscriptionLabel.text == "" || noteDiscriptionLabel.text == "Note Discription ..."{
            let alertController = UIAlertController(title: "Missing Information", message: "You left one ore mor  e fields empty. Let's make sure that all fields are filled before attempting to save", preferredStyle: UIAlertControllerStyle.alert)
            
            let OkAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
            
            alertController.addAction(OkAction)

            self.present(alertController,animated: true, completion: nil)
            
        }
        else{
            if(isExisting == false ){
                let noteName = noteNameLabel.text
                let noteDiscription = noteDiscriptionLabel.text
                
                if let mana = manageObjectContext{
                    let note = Note(context: mana)
                    if let data = UIImageJPEGRepresentation(self.noteImageView.image!, 1.0){
                        note.noteImage = data as Data
                    }
                    note.noteName = noteName
                    note.noteDiscription = noteDiscription
                    saveToCoreData(){
                        let isPresentingInAddNoteMode = self.presentingViewController is UINavigationController
                        if isPresentingInAddNoteMode{
                            self.dismiss(animated: true, completion: nil)
                        }
                        else {
                            self.navigationController!.popViewController(animated: true)
                        }
                    }
                }
            }
            else if (isExisting == true ){
                let note = self.note
                let manageObject = note
                manageObject?.setValue(noteNameLabel.text, forKey: "noteName")
                manageObject?.setValue(noteDiscriptionLabel.text, forKey: "noteDiscription")
                
                if let data = UIImageJPEGRepresentation(self.noteImageView.image!, 1.0){
                    manageObject?.setValue(data, forKey: "noteImage")
                }
                do {
                    try context.save()
                    let isPresentingInAddNoteMode = self.presentingViewController is UINavigationController
                    if isPresentingInAddNoteMode{
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                catch{
                    print("failed to update existing note ")
                }
            }
        }
    }
    
    // cancel
    @IBAction func cancel(_ sender: Any) {
        let isPresentingInAddNoteMode = presentingViewController is UINavigationController
        if isPresentingInAddNoteMode{
            self.dismiss(animated: true, completion: nil)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    // text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Note Discription ..."){
            textView.text = ""
        }
    }
    
}

extension UITextField{
    func setButtonBorder(){
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 245.0/255.0, green: 79.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
}
