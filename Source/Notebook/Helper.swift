//
//  Helper.swift
//  Notebook
//
//  Created by LeHoangSang on 1/16/19.
//  Copyright © 2019 Sang Leo. All rights reserved.
//

import UIKit

class UI {
    static func addDoneButtonForTextField(controls: [UITextField]){
        for textField in controls{
            let toolbar = UIToolbar()
            toolbar.items = [
                UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
                UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: textField, action: #selector(UITextField.resignFirstResponder))
            ]
            toolbar.sizeToFit()
            textField.inputAccessoryView = toolbar
        }
    }
}
