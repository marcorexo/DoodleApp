//
//  ViewController.swift
//  doodleBug
//
//  Created by Apple MacBook on 30/10/2019.
//  Copyright © 2019 Apple MacBook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    
    var swiped = false
    var lastPoint = CGPoint.zero
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var brushWidth: Int = 5
    
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //if a new touch occurs set lastPoint to the current location
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false
        
        if let touch = touches.first as UITouch! {
            
            lastPoint = touch.location(in: self.imageView)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        swiped = true
        
        if let touch = touches.first as UITouch! {
            
            let currentPoint = touch.location(in: self.imageView)
            drawLine(lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            
            drawLine(lastPoint, toPoint: lastPoint)
        }
    }
    
    func drawLine(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        //Creates a bitmap-based graphics context
        UIGraphicsBeginImageContext(self.imageView.frame.size)
        
            let context = UIGraphicsGetCurrentContext()
            
            imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.imageView.frame.width, height: self.imageView.frame.height))
            
            //setup the line properties
            context?.setLineCap(CGLineCap.round)
            context?.setLineWidth(CGFloat(brushWidth))
            context?.setStrokeColor(red:red, green: green, blue: blue, alpha: 1)
            context?.setBlendMode(CGBlendMode.normal)
        
            context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y)) // move pen to fromPoint
            context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y)) // make line to the toPoint
            
            //paint line between points
            context?.strokePath()
            
            //add context to the image view
            imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    
    @IBAction func redButton_clicked(_ sender: Any) {
        
        (red, green, blue) = (255.0, 0.0, 0.0)
    }
    
    
    @IBAction func greenButton_clicked(_ sender: Any) {
        
        (red, green, blue) = (0.0, 255.0, 0.0)
    }
    
    
    @IBAction func blueButton_clicked(_ sender: Any) {
        
        (red, green, blue) = (0.0, 0.0, 255.0)
    }
    
    
    @IBAction func eraseButton_clicked(_ sender: Any) {
        
        (red, green, blue) = (255.0, 255.0, 255.0)
    }
    
    
    @IBAction func minusButton_clicked(_ sender: Any) {
        
        brushWidth -= 1
        processBrushSize()
    }
    
    
    @IBAction func plusButton_clicked(_ sender: Any) {
        
        brushWidth += 1
        processBrushSize()
    }
    
    
    func processBrushSize() {
        
        sizeLabel.text = "\(brushWidth)"
        
        switch brushWidth {
        case 1:
            minusButton.isEnabled = false
            minusButton.alpha = 0.3
        case 20:
            plusButton.isEnabled = false
            plusButton.alpha = 0.3
        default:
            minusButton.isEnabled = true
            minusButton.alpha = 1.0
            
            plusButton.isEnabled = true
            plusButton.alpha = 1.0
        }
    }
    
    
    @IBAction func resetButton_clicked(_ sender: Any) {
        
        imageView.image = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.delegate = self
        
        settingsViewController.brushWidth = brushWidth
    }
}

extension ViewController: SettingsViewControllerDelegate {
    
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController) {
        
        self.brushWidth = settingsViewController.brushWidth
        
        self.processBrushSize()
    }
}
