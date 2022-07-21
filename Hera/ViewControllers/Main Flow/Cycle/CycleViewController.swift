//
//  CycleViewController.swift
//  Hera
//
//  Created by Andreas Lordos on 7/21/22.
//

import UIKit
import MSCircularSlider

class CycleViewController: UIViewController, MSCircularSliderProtocol, MSCircularSliderDelegate {
    

    @IBOutlet weak var slider: MSCircularSlider!
    
    var cycleLength: Int = 28 // change this to get data frmo predictions
    var cycleStartDate: Date = Date()
    var currentDayInCycle: Int = -1
    var ovulationPeriod = (11, 15)
    var periodDuration = 4
    var cycleEndDate: Date = Date()
    var valueBetweenLabels = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slider.delegate = self;
        createSlider();
        // Do any additional setup after loading the view.
    }
    
    func createSlider() {
        createLabels()
        
        self.slider.currentValue = 60.0
        self.slider.maximumAngle = 320.0
        
        self.valueBetweenLabels = 100 / Double(cycleLength)
        
        self.slider.lineWidth = 20
        
        //self.slider.snapToLabels = true
        
        self.slider.filledColor = UIColor(red: 127 / 255.0, green: 168 / 255.0, blue: 198 / 255.0, alpha: 1.0)
        self.slider.unfilledColor = UIColor(red: 80 / 255.0, green: 148 / 255.0, blue: 95 / 255.0, alpha: 1.0)
        self.slider.handleType = .doubleCircle
        self.slider.handleColor = UIColor(red: 35 / 255.0, green: 69 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        self.slider.handleEnlargementPoints = 12
        
        
    }
    
    func createLabels() {
        var labels = ["1"]
        for x in 2...cycleLength {
            labels.append(String(x))
        }
        self.slider.labels = labels
        self.slider.labelColor = UIColor .systemBackground
    }
    
    
    // snap to cycle days instead of being able to "float" between them
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        if fromUser {
            if (value.truncatingRemainder(dividingBy: valueBetweenLabels)  < (valueBetweenLabels / 2.0)) {
                self.slider.currentValue = value - value.truncatingRemainder(dividingBy: valueBetweenLabels)
            }
            else {
                    self.slider.currentValue = value + (valueBetweenLabels - value.truncatingRemainder(dividingBy: valueBetweenLabels))
            }
        }
        print(value)
    }

}
