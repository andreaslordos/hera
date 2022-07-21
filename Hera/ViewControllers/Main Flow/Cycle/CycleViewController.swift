//
//  CycleViewController.swift
//  Hera
//
//  Created by Andreas Lordos on 7/21/22.
//

import UIKit
import MSCircularSlider

class CycleViewController: UIViewController, MSCircularSliderProtocol, MSCircularSliderDelegate {
    

    @IBOutlet weak var dayCounter: UILabel!
    @IBOutlet weak var slider: MSCircularSlider!
    
    var cycleLength: Int = 28 // change this to get data frmo predictions
    var cycleStartDate: Date = Date() // initialized to today
    var currentDayInCycle: Int = 3
    var currentDayShown: Int = 3
    var ovulationPeriod = (11, 15)
    var periodDuration = (1, 4)
    var cycleEndDate: Date = Date() // initialized to today
    var valueBetweenLabels = 0.0 // initialized to 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slider.delegate = self;
        createSlider();
        // Do any additional setup after loading the view.
    }
    
    func createSlider() {
        self.valueBetweenLabels = 100 / Double(cycleLength-1)
        createLabels()
        
        self.slider.currentValue = Double(self.currentDayInCycle - 1) / Double(cycleLength - 1) * 100.0
        snapToClosestDay(self.slider.currentValue)
        
        self.slider.maximumAngle = 320.0
                
        self.slider.lineWidth = 20
        
        self.slider.snapToLabels = true
        
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
    
    func addOrSubtractDay(day:Int)->Date{
      return Calendar.current.date(byAdding: .day, value: day, to: Date())!
    }

    func determineCycle() {
        self.cycleStartDate = addOrSubtractDay(day: -(self.currentDayInCycle - 1))
        self.cycleEndDate = addOrSubtractDay(day: self.cycleLength - self.currentDayInCycle)
    }
    
    func updateDayShown() {
        dayCounter.text = String(self.currentDayShown)
    }
    
    func valueToCurrentDay(_ value: Double) {
        let previousDay = self.currentDayShown
        let newDay = Int((value / 100.0) * Double(cycleLength - 1)) + 1
        if newDay != previousDay {
            currentDayShown = newDay
            updateDayShown()
        }
    }
    
    func snapToClosestDay(_ value: Double) {
        if (value.truncatingRemainder(dividingBy: valueBetweenLabels)  < (valueBetweenLabels / 2.0)) {
            self.slider.currentValue = value - value.truncatingRemainder(dividingBy: valueBetweenLabels)
        }
        else {
            self.slider.currentValue = value + (valueBetweenLabels - value.truncatingRemainder(dividingBy: valueBetweenLabels))
        }
    }
    
    
    // snap to cycle days instead of being able to "float" between them
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        if (fromUser) {
            snapToClosestDay(value)
            valueToCurrentDay(self.slider.currentValue)
        }
        print(value)
    }

}
