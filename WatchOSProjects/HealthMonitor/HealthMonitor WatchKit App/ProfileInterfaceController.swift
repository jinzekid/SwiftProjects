//
//  ProfileInterfaceController.swift
//  HealthMonitor
//
//  Created by YangLu on 16/6/26.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

class ProfileInterfaceController: WKInterfaceController {

    @IBOutlet var profileDOB: WKInterfaceLabel!
    @IBOutlet var profileAge: WKInterfaceLabel!
    @IBOutlet var profileSexType: WKInterfaceLabel!
    @IBOutlet var profileBloodType: WKInterfaceLabel!
    
    let healthKitStore = HKHealthStore()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        self.profileDOB.setText("---")
        self.profileAge.setText("---")
        self.profileSexType.setText("---")
        self.profileBloodType.setText("---")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // Set up our profile characteristics
        let dateOfBirth = getProfileDOB()!
        let calculatedAge = calculateAgeOfPersion(dateOfBirth)
        let sexType = getProfileSexType()!
        let BloodType = getProfileBloodType()!
        
        self.profileDOB.setText(dateOfBirth)
        self.profileAge.setText(String(UInt16(calculatedAge!)))
        self.profileSexType.setText(sexType)
        self.profileBloodType.setText(BloodType)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // Calculate the age based on the date of birth
    func calculateAgeOfPersion(birthDate: String) -> Int? {
        // Request the user's Birthday and calculate the age
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        
        let today = NSDate()
        let calender = NSCalendar.currentCalendar()
        let dateComponents = calender.components(.Year, fromDate: dateFormatter.dateFromString(birthDate)!, toDate: today, options: .WrapComponents)
        
        // Calculate the age and return
        return dateComponents.year
    }
    
    func getProfileDOB() -> String? {
        var dateOfBirth: String?
        
        do {
            // Request the user's birthday and calculate the age
            let birthdate = try healthKitStore.dateOfBirth()
            // Get the date of birth and format it
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            dateOfBirth = dateFormatter.stringFromDate(birthdate)
        } catch { return nil }
        
        // Return our date of birth information
        return dateOfBirth
    }
    
    // Get the biological sex information
    func getProfileSexType() -> String? {
        var biologicalSexType: String?
    
        do {
            let biologicalSex = try healthKitStore.biologicalSex()
            switch biologicalSex.biologicalSex {
            case .Female:
                biologicalSexType = "Female"
            case .Male:
                biologicalSexType = "Male"
            default:
                biologicalSexType = ""
            }
        } catch { return nil }
        
        return biologicalSexType
    }
    
    // Get the Biological Blood Type Information
    func getProfileBloodType() -> String? {
        var biologicalBloodType: String?
        
        do {
            let bloodType = try healthKitStore.bloodType()
            switch bloodType.bloodType {
            case .APositive:
                biologicalBloodType = "A+"
            case .ANegative:
                biologicalBloodType = "A-"
            case .BPositive:
                biologicalBloodType = "B+"
            case .BNegative:
                biologicalBloodType = "B-"
            case .ABPositive:
                biologicalBloodType = "AB+"
            case .ABNegative:
                biologicalBloodType = "AB-"
            case .OPositive:
                biologicalBloodType = "O+"
            case .ONegative:
                biologicalBloodType = "O-"
            case .NotSet:
                biologicalBloodType = ""
            }
        } catch { return nil }
        
        return biologicalBloodType
    }
    
    
}
