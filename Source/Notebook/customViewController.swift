//
//  customViewController.swift
//  Notebook
//
//  Created by Mai on 12/11/18.
//  Copyright © 2018 Sang Leo. All rights reserved.
//

import UIKit

class customViewController: UITabBarController {
    
    var tabBarIteam =  UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.darkGray], for: .normal)
        
        let selectedImage1 = UIImage(named: "note2")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage1 = UIImage(named: "note1")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items![0]
        tabBarIteam.image = deSelectedImage1
        tabBarIteam.selectedImage = selectedImage1
        
        let selectedImage2 = UIImage(named: "todo2")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage2 = UIImage(named: "todo1")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items![1]
        tabBarIteam.image = deSelectedImage2
        tabBarIteam.selectedImage = selectedImage2
        
        let numberOfTabs =  CGFloat((tabBar.items?.count)!)
        let tabBarSize = CGSize(width: tabBar.frame.width / numberOfTabs, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), size: tabBarSize)
        self.selectedIndex = 0
        
        
    }

}

extension UIImage {
   class  func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

