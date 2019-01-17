//
//  PaintViewController.swift
//  Notebook
//
//  Created by LeHoangSang on 1/16/19.
//  Copyright © 2019 Sang Leo. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController {

    let colorArray:[Int] = [ 0x000000, 0x262626, 0x4d4d4d, 0x666666, 0x808080, 0x990000, 0xcc0000, 0xfe0000, 0xff5757, 0xffabab, 0xffabab, 0xffa757, 0xff7900, 0xcc6100, 0x994900, 0x996f00, 0xcc9400, 0xffb900, 0xffd157, 0xffe8ab, 0xfff4ab, 0xffe957, 0xffde00, 0xccb200, 0x998500, 0x979900, 0xcacc00, 0xfcff00, 0xfdff57, 0xfeffab, 0xf0ffab, 0xe1ff57, 0xd2ff00, 0xa8cc00, 0x7e9900, 0x038001, 0x04a101, 0x05c001, 0x44bf41, 0x81bf80, 0x81c0b8, 0x41c0af, 0x00c0a7, 0x00a18c, 0x00806f, 0x040099, 0x0500cc, 0x0600ff, 0x5b57ff, 0xadabff, 0xd8abff, 0xb157ff, 0x6700bf, 0x5700a1, 0x450080, 0x630080, 0x7d00a1, 0x9500c0, 0xa341bf, 0xb180bf, 0xbf80b2, 0xbf41a6, 0xbf0199, 0xa10181, 0x800166, 0x999999, 0xb3b3b3, 0xcccccc, 0xe6e6e6, 0xffffff]
    
    @IBOutlet weak var canvasView: CanvasView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var backgroundSlider: UISlider!
    
    @IBOutlet weak var txtSize: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSize.layer.cornerRadius = 18
        
        // Do any additional setup after loading the view.
    }
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    @IBAction func btnClear_Click(_ sender: Any) {
        canvasView.clearCanvas()
        backgroundSlider.isEnabled = true
    }
    
    @IBAction func btnOK_Click(_ sender: Any) {
        var img = UIImage.imageWithView(canvasView)
        
        let arlertController = UIAlertController(title: "Notification", message: "Do you want to save image to your device ?", preferredStyle: .actionSheet)
        
        let YesAction = UIAlertAction(title: "Yes", style: .default){
            (action ) in
            let imageData = UIImagePNGRepresentation(img)
            let compressedImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert,animated: true,completion: nil)
        }
        
        let NoAction = UIAlertAction(title: "No", style: .default, handler: nil)
        
        arlertController.addAction(YesAction)
        arlertController.addAction(NoAction)
        
        present(arlertController, animated: true, completion: nil)
    }
    
    @IBAction func sliderLineColorChanged(_ sender: Any) {
        canvasView.changeLineColor(color:colorArray[Int(slider.value)])
        slider.thumbTintColor = uiColorFromHex(rgbValue: colorArray[Int(slider.value)])
    }
    
    @IBAction func sliderBackGroundChanged(_ sender: Any) {
        canvasView.backgroundColor = uiColorFromHex(rgbValue: colorArray[Int(backgroundSlider.value)])
        backgroundSlider.thumbTintColor = uiColorFromHex(rgbValue: colorArray[Int(backgroundSlider.value)])
    }
    
    
    
    @IBAction func btnIncreaseSize_Click(_ sender: Any) {
        var size = Int(txtSize.text!)!
        size = size + 1;
        txtSize.text = String(size)
        canvasView.changeLineSize(size: size)
    }
    
    @IBAction func btnDecreaseSize_Click(_ sender: Any) {
        var size = Int(txtSize.text!)!
        size = size - 1
        if (size < 1)
        {
            size = size + 1
        }
        txtSize.text = String(size)
        canvasView.changeLineSize(size: size)
    }
    
    @IBAction func btnDraw_Click(_ sender: Any) {
        canvasView.changeLineColor(color:colorArray[Int( slider.value)])
        
    }
    
    
    @IBAction func btnErase_Click(_ sender: Any) {
        canvasView.changeLineColor(color:colorArray[Int(backgroundSlider.value)])
      backgroundSlider.isEnabled = false
    }
    
}

extension UIImage {
    class func imageWithView(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}

extension UIView {
    
    func image () -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}
