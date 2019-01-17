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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor( red : 39.0/255.0 , green : 174.0/255.0 , blue : 96.0/255.0 , alpha : 1.0 )], for: .normal)
        
        let selectedImage1 = UIImage(named: "note_deactive")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage1 = UIImage(named: "note_active")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items![0]
        tabBarIteam.image = deSelectedImage1
        tabBarIteam.selectedImage = selectedImage1
        
        let selectedImage2 = UIImage(named: "todo_deactive")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage2 = UIImage(named: "todo_active")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items![1]
        tabBarIteam.image = deSelectedImage2
        tabBarIteam.selectedImage = selectedImage2
        
        let selectedImage3 = UIImage(named: "paint_deactive")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage3 = UIImage(named: "paint_active")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items![2]
        tabBarIteam.image = deSelectedImage3
        tabBarIteam.selectedImage = selectedImage3
        
        let numberOfTabs =  CGFloat((tabBar.items?.count)!)
        let tabBarSize = CGSize(width: tabBar.frame.width / numberOfTabs, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor( red : 39.0/255.0 , green : 174.0/255.0 , blue : 96.0/255.0 , alpha : 1.0 ), size: tabBarSize)
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

