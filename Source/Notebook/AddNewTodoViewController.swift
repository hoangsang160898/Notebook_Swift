//
//  AddNewTodoViewController.swift
//  Notebook
//
//  Created by Sang Leo on 1/16/19.
//  Copyright © 2019 Sang Leo. All rights reserved.
//

import UIKit
import CoreData

class AddNewTodoViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    var managedContext: NSManagedObjectContext!
    var todo: TODO?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with:)),
            name: .UIKeyboardWillShow,
            object: nil
        )
        textView.becomeFirstResponder()
        if let todo = todo {
            textView.text = todo.title
            textView.text = todo.title
            segmentedControl.selectedSegmentIndex = Int(todo.priority)
        }
        
    }
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height + 16
        
        bottomConstraint.constant = keyboardHeight
        
        if(textView.text == "Write here..."){
            textView.text.removeAll()
        }
        //
        //textView.text.removeAll()
        textView.textColor = .white
        //
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        
        
    }
    
    
    fileprivate func extractedFunc() {
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        extractedFunc()
    }
    @IBAction func done(_ sender: UIButton) {
        
        guard let title = textView.text, !title.isEmpty else {
            return
        }
        
        if let todo = self.todo {
            todo.title = title
            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
        } else {
            let todo = TODO(context: managedContext)
            todo.title = title
            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
            todo.date = Date()
        }
        
        do {
            try managedContext.save()
            extractedFunc()
        } catch {
            print("Error saving todo: \(error)")
        }
    }
    
}

/*
 extension AddTodoViewController: UITextViewDelegate {
 func textViewDidChangeSelection(_ textView: UITextView) {
 if doneButton.isHidden {
 textView.text.removeAll()
 textView.textColor = .white
 
 doneButton.isHidden = false
 
 UIView.animate(withDuration: 0.3) {
 self.view.layoutIfNeeded()
 }
 }
 }
 }*/


