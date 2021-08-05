//
//  ContentView.swift
//  MitoHealth
//
//  Created by Andreas on 8/3/21.
//

import SwiftUI
import SFSafeSymbols
import HealthKit
struct ContentView: View {
    @State var userData = UserData(id: UUID().uuidString, type: .EmotionTagging, title: "", text: "", date: Date(), data: 0.0)
    @State var habits = [Habit]()
    @State var data = [UserData]()
    let healthStore = HKHealthStore()
    
    @State var healthDataTypes = [HKQuantityTypeIdentifier]()
    @State var dataTypes = UserDefaults.standard.stringArray(forKey: "types") ?? []
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    let types: [HKQuantityTypeIdentifier] = [.walkingStepLength, .walkingSpeed, .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage]
                    healthDataTypes = types
                    let readData = Set(
                        healthDataTypes.map{HKObjectType.quantityType(forIdentifier: $0)!}
                    )
                    
                    self.healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                        
                        
                    }
                    for type in healthDataTypes {
                    getHealthData(type: type, dateDistanceType: .Month, dateDistance: 12) { (healthValues) in
                    }
                    }
                }
            
                .onChange(of: habits) { value in
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(habits) {
                        if let json = String(data: encoded, encoding: .utf8) {
                          
                            do {
                                let url = self.getDocumentsDirectory().appendingPathComponent("habits.txt")
                                try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                
                            } catch {
                                print("erorr")
                            }
                        }
                        
                        
                    }
                }
                .onAppear() {
                    let url3 = self.getDocumentsDirectory().appendingPathComponent("habits.txt")
                    do {
                        
                        let input = try String(contentsOf: url3)
                        
                        
                        let jsonData = Data(input.utf8)
                        do {
                            let decoder = JSONDecoder()
                            
                            do {
                                let note = try decoder.decode([Habit].self, from: jsonData)
                                
                                habits = note
                                print(note)
                               
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                }  catch {
                    print(error.localizedDescription)
                }
            }
        TabView {
            
            CollectListView(habits: $habits, dataTypes: $dataTypes)
                .tabItem {
                    Label("Home", systemImage: SFSymbol.house.rawValue)
                }
                
            TrainingView(userData: $data, dataTypes: $dataTypes)
                     .tabItem {
                         Label("Training", systemImage: SFSymbol.scope.rawValue)
                     }

            JournalInput(userData: $userData)
                     .tabItem {
                         Label("Journal", systemImage: SFSymbol.book.rawValue)
                     }
             }
      
    }
    }
    func getHealthData(type: HKQuantityTypeIdentifier, dateDistanceType: DateDistanceType, dateDistance: Int, completionHandler: @escaping ([UserData]) -> Void) {
        var data = [UserData]()
        let calendar = NSCalendar.current
        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
        
        let offset = (7 + anchorComponents.weekday! - 2) % 7
        
        anchorComponents.day! -= offset
        anchorComponents.hour = 2
        
        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
            fatalError("*** unable to create a valid date from the given components ***")
        }
        
        let interval = NSDateComponents()
        interval.minute = 30
        
        let endDate = Date()
        
        guard let startDate = calendar.date(byAdding: (dateDistanceType == .Week ? .day : .month), value: -dateDistance, to: endDate) else {
            fatalError("*** Unable to calculate the start date ***")
        }
        guard let quantityType3 = HKObjectType.quantityType(forIdentifier: type) else {
            fatalError("*** Unable to create a step count type ***")
        }
        
        let query3 = HKStatisticsCollectionQuery(quantityType: quantityType3,
                                                 quantitySamplePredicate: nil,
                                                 options: [.discreteAverage],
                                                 anchorDate: anchorDate,
                                                 intervalComponents: interval as DateComponents)
        
        query3.initialResultsHandler = {
            query, results, error in
            
            if let statsCollection = results {
                
            
            
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
              
                if let quantity = statistics.averageQuantity() {
                    let date = statistics.startDate
                    //for: E.g. for steps it's HKUnit.count()
                    let value = quantity.is(compatibleWith: .percent()) ? quantity.doubleValue(for: .percent()) : quantity.is(compatibleWith: .count()) ? quantity.doubleValue(for: .count()) : quantity.is(compatibleWith: .inch()) ? quantity.doubleValue(for: .inch()) : quantity.doubleValue(for: HKUnit.mile().unitDivided(by: HKUnit.hour()))
                    data.append(UserData(id: UUID().uuidString, type: .Health, title: type.rawValue, text: "", date: date, data: value))
                    self.data.append(UserData(id: UUID().uuidString, type: .Health, title: type.rawValue, text: "", date: date, data: value))
                    print(type.rawValue)
                  
                    
    }
            
            }
                
        }
            
            completionHandler(data)
        }
        
        healthStore.execute(query3)
        
       
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}


