//
//  Data.swift
//  Data
//
//  Created by Andreas on 8/3/21.
//

import SwiftUI
import HealthKit
enum DataType: String, Codable, CaseIterable {
    case StepLength = "StepLength"
    case Health = "Health"
    case EmotionTagging = "EmotionTagging"
    case Heartrate = "Heartrate"
    case PhoneUsage = "PhoneUsage"
    case Habit = "Habit"
    case Meds = "Meds"
    case Food = "Food"
    case HappinessScore = "HappinessScore"
    case Score = "Score"
    
}


enum DateDistanceType: String, Codable, CaseIterable {
    case Week = "Week"
    case Month = "Month"
    
}
struct UserData: Identifiable, Codable, Hashable {
    var id: String
    var type: DataType
    var title: String
    var text: String
    var date: Date
    var data: Double

    
    
}
struct Habit:  Identifiable, Codable, Hashable {
    var id: String
    var data: [UserData]
    var title: String
}

struct ModelResponse: Codable {
    var type: String
    var predicted: [Double]
    var actual: [Double]
    var accuracy: Double
}
