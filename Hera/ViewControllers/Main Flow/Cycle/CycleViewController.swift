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
    @IBOutlet weak var nextPeriod: UILabel!
    @IBOutlet weak var fertileWindow: UILabel!
    @IBOutlet weak var slider: MSGradientCircularSlider!
    @IBOutlet weak var bleedingLabel: UILabel!
    @IBOutlet weak var fertileLabel: UILabel!
    
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
        determineCycle()
        createSlider()
        updateDayShown()
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
        
        self.slider.gradientColors = [.red, .blue, .purple, .purple];
        self.slider.unfilledColor = .purple;
        //self.slider.filledColor = UIColor(red: 127 / 255.0, green: 80.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
        //self.slider.unfilledColor = UIColor(red: 80 / 255.0, green: 148 / 255.0, blue: 95 / 255.0, alpha: 1.0)
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
    
    func dateToString(_ date: Date) -> String {
        let dateFormat = "MMM dd"
        let formatter1 = DateFormatter()
        formatter1.dateFormat = dateFormat
        return formatter1.string(from: date)
    }

    func determineCycle() {
        self.cycleStartDate = addOrSubtractDay(day: -(self.currentDayInCycle - 1))
        self.cycleEndDate = addOrSubtractDay(day: self.cycleLength - self.currentDayInCycle)
        let nextPeriodDay = Calendar.current.date(byAdding: .day, value: 1, to: self.cycleEndDate)!
        self.nextPeriod.text = "Next period on " + dateToString(nextPeriodDay)
    }
    
    func updateDayShown() {
        
        self.fertileLabel.attributedText = NSAttributedString()
        self.bleedingLabel.attributedText = NSAttributedString()

        if (self.currentDayShown == self.currentDayInCycle) {
            dayCounter.text = "Today"
        }
        else {
            dayCounter.text = "Day " + String(self.currentDayShown)
        }
        dayCounter.text = (dayCounter.text ?? "")! + " (" + dateToString(addOrSubtractDay(day: currentDayShown)) + ")"
        if (self.currentDayShown >= self.periodDuration.0 && self.currentDayShown <= self.periodDuration.1) {
            self.fertileWindow.text = "Bleeding"
            
            let boldText = "Bleeding"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

            if (self.periodDuration.1 - self.currentDayShown == 0) {
                attributedString.append(NSMutableAttributedString(string:" ending today"))
            }
            else {
                let normalText = " for the next "
                let normalString = NSMutableAttributedString(string:normalText)

                attributedString.append(normalString)
                
                
                let boldText2 = (self.periodDuration.1 - self.currentDayShown) == 1 ?
                "day" :
                (String(self.periodDuration.1 - self.currentDayShown) + " days")
                let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
                let attributedString2 = NSMutableAttributedString(string:boldText2, attributes:attrs2)
                attributedString.append(attributedString2)
            }
            bleedingLabel.attributedText = attributedString
        }
        else if (self.currentDayShown >= self.ovulationPeriod.0 && self.currentDayShown <= self.ovulationPeriod.1) {
            self.fertileWindow.text = "Fertile window"
            let boldText = "Fertile window"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

            if (self.ovulationPeriod.1 - self.currentDayShown == 0) {
                attributedString.append(NSMutableAttributedString(string:" ending today"))
            }
            else {
                let normalText = " for the next "
                let normalString = NSMutableAttributedString(string:normalText)

                attributedString.append(normalString)
                
                
                let boldText2 = (self.ovulationPeriod.1 - self.currentDayShown) == 1 ?
                "day" :
                (String(self.ovulationPeriod.1 - self.currentDayShown) + " days")
                let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
                let attributedString2 = NSMutableAttributedString(string:boldText2, attributes:attrs2)
                attributedString.append(attributedString2)
            }
            fertileLabel.attributedText = attributedString
        }
        else {
            self.fertileWindow.text = ""
        }
    }
    
    func valueToCurrentDay(_ value: Double) {
        let previousDay = self.currentDayShown
        let newDay = Int(round((value / 100.0) * Double(cycleLength - 1))) + 1
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
