//
//  SettingsViewController.swift
//  doodleBug
//
//  Created by Apple MacBook on 30/10/2019.
//  Copyright © 2019 Apple MacBook. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController)
}


class SettingsViewController: UIViewController {
    
    var delegate: SettingsViewControllerDelegate?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var brushSizeLabel: UILabel!
    @IBOutlet var brushSizeSlider: UISlider!
    
    @IBOutlet var opacityLabel: UILabel!
    @IBOutlet var opacitySlider: UISlider!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var colourLabel: UILabel!
    
    var brushWidth: Int = 5
    
    var red: CGFloat = 127.0
    var green: CGFloat = 127.0
    var blue: CGFloat = 127.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        brushSizeSlider.value = Float(CGFloat(brushWidth))
        brushSizeLabel.text = "Brush size: \(brushWidth)"
        
        updateColourLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func exitButton_clicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        self.delegate?.settingsViewControllerFinished(self)
        
    }
    
    @IBAction func brushSizeSlider_action(_ sender: Any) {
        
        brushWidth = Int(brushSizeSlider.value)
        brushSizeLabel.text = "Brush size: \(brushWidth)"
    }
    
    @IBAction func opacitySlider_action(_ sender: Any) {
    }
    
    
    @IBAction func redSlider_action(_ sender: Any) {
        
        red = CGFloat(redSlider.value)
        updateColourLabel()
    }
    
    @IBAction func greenSlider_action(_ sender: Any) {
        
        green = CGFloat(greenSlider.value)
        updateColourLabel()
    }
    
    @IBAction func blueSlider_action(_ sender: Any) {
        
        blue = CGFloat(blueSlider.value)
        updateColourLabel()
    }
    
    func updateColourLabel() {
        
        colourLabel.text = "Red: \(red)     Green: \(green)     Blue: \(blue)"
        imageView.tintColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    

}
