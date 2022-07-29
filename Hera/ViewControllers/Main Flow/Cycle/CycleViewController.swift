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
    
    var user: User!
    var cycle: Cycle!
    var cycleLength: Int!
    var cycleStartDate: Date!
    var currentDayInCycle: Int!
    var currentDayShown: Int!
    var ovulationPeriod: (Int, Int)!
    var periodDuration: (Int, Int)!
    var cycleEndDate: Date!
    var valueBetweenLabels = 0.0 // initialized to 0
    
    override func viewDidLoad() {
        self.user = Utilities.getUserFromParent(self)
        determineCycle()
        super.viewDidLoad()
        self.slider.delegate = self;
        createSlider()
        updateDayShown()
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
    
    func dateToString(_ date: Date) -> String {
        let dateFormat = "MMM dd"
        let formatter1 = DateFormatter()
        formatter1.dateFormat = dateFormat
        return formatter1.string(from: date)
    }

    func determineCycle() {
        self.cycle = self.user.cyclesFuture?.cycles?.firstObject as? Cycle
        self.cycleStartDate = self.cycle.startDate;
        self.cycleEndDate = self.cycle.endDate;
        self.cycleLength = Utilities.getDaysBetween(self.cycleStartDate, to: self.cycleEndDate) + 1
        self.currentDayInCycle = Utilities.getDaysSince(cycleStartDate)
        self.currentDayShown = self.currentDayInCycle;
        let ovulationStart = Utilities.getDaysBetween(self.cycleStartDate, to: self.cycle.ovulationStart!)
        let ovulationEnd = ovulationStart + Int(self.cycle.ovulationDuration)
        self.ovulationPeriod = (ovulationStart, ovulationEnd)
        self.periodDuration = (1, Int(self.cycle.periodDuration))
        self.cycleEndDate = self.cycle.endDate
        
        let nextPeriodDay = Calendar.current.date(byAdding: .day, value: 1, to: self.cycleEndDate)!
        self.nextPeriod.text = "Next period on " + dateToString(nextPeriodDay)
    }
    
    func updateDayShown() {
        self.slider.handleColor = UIColor(red: 35 / 255.0, green: 69 / 255.0, blue: 96 / 255.0, alpha: 1.0)

        self.fertileLabel.attributedText = NSAttributedString()
        self.bleedingLabel.attributedText = NSAttributedString()

        if (self.currentDayShown == self.currentDayInCycle) {
            dayCounter.text = "Today"
            self.slider.handleColor = UIColor.yellow
        }
        else {
            dayCounter.text = "Day " + String(self.currentDayShown)
        }
        dayCounter.text = (dayCounter.text ?? "")! + " (" + dateToString(Utilities.getDateByYearOffset(0, monthOffset: 0, dayOffset: Int32(self.currentDayShown)-1, date: self.cycleStartDate)) + ")"
        
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
            
            let daysLeft = self.ovulationPeriod.1 - self.currentDayShown
            if (daysLeft == 0) {
                attributedString.append(NSMutableAttributedString(string:" ending today"))
            }
            else {
                let normalText = " for the next "
                let normalString = NSMutableAttributedString(string:normalText)

                attributedString.append(normalString)
                
                
                let boldText2 = (daysLeft) == 1 ?
                "day" :
                (String(daysLeft) + " days")
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
    }
}
