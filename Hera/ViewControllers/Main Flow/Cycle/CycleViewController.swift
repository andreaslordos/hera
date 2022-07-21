//
//  CycleViewController.swift
//  Hera
//
//  Created by Andreas Lordos on 7/21/22.
//

import UIKit
import MSCircularSlider

class CycleViewController: UIViewController, MSCircularSliderProtocol, MSCircularSliderDelegate {
    
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        <#code#>
    }
    

    @IBOutlet weak var slider: MSCircularSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slider.delegate = self;
        createSlider();
        // Do any additional setup after loading the view.
    }
    
    func createSlider() {
        self.slider.currentValue = 60.0
        self.slider.maximumAngle = 300.0
        self.slider.filledColor = UIColor(red: 127 / 255.0, green: 168 / 255.0, blue: 198 / 255.0, alpha: 1.0)
        self.slider.unfilledColor = UIColor(red: 80 / 255.0, green: 148 / 255.0, blue: 95 / 255.0, alpha: 1.0)
        self.slider.handleType = .doubleCircle
        self.slider.handleColor = UIColor(red: 35 / 255.0, green: 69 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        self.slider.handleEnlargementPoints = 12
        self.slider.labels = ["1", "2", "3", "4", "5"]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
