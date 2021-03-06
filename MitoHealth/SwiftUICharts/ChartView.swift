//
//  ChartView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
struct WeekChartView: View {
    
   
    @Binding var chartData: ChartData
    @State var refresh = false
    var body: some View {
        ZStack {
            Color.clear
        
            BarChartView(data: $chartData, title: "", legend: "", refresh: $refresh)
            
        }
    }
    func average(numbers: [Double]) -> Double {
        // print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
}
//struct MedsWeekChartView: View {
//    
//    @Binding var week: Week
//    @State var chartData = ChartData(values: [("", 0.0)])
//    @Binding var med: Med
//    @State var refresh = false
//    var body: some View {
//        ZStack {
//            Color.clear
//                .onChange(of: med, perform: { value in
//                    organize()
//                    print(week)
//                })
//                .onAppear() {
//                    organize()
//                }
//            if !refresh {
//            BarChartView(data: $chartData, title: "Meds", legend: "", refresh: $refresh)
//            }
//        }
//    }
//    func organize() {
//        refresh = true
//        let filtered = week.mon.meds.filter { day in
//         
//            return day.name == med.name
//        }
//        let filtered2 = week.tue.meds.filter { day in
//           
//            return day.name == med.name
//        }
//        let filtered3 = week.wed.meds.filter { day in
//           
//            return day.name == med.name
//        }
//        let filtered4 = week.thur.meds.filter { day in
//           
//            return day.name == med.name
//        }
//        let filtered5 = week.fri.meds.filter { day in
//           
//            return day.name == med.name
//        }
//        let filtered6 = week.sat.meds.filter { day in
//            print(day.name)
//             print(med.name)
//            return day.name == med.name
//        }
//        print(filtered6)
//        let filtered7 = week.sun.meds.filter { day in
//           
//            return day.name == med.name
//        }
//        chartData = ChartData(values: [( "Monday", Double(filtered.last?.amountTaken ?? 0.0)), ("Tuesday", Double(filtered2.last?.amountTaken ?? 0.0)), ( "Wednesday", Double(filtered3.last?.amountTaken ?? 0.0)) ])
//        chartData.points.append(( "Thursday", Double(filtered4.last?.amountTaken ?? 0.0)))
//        chartData.points.append( ( "Friday", Double(filtered5.last?.amountTaken ?? 0.0)))
//        chartData.points.append(( "Saturday", Double(filtered6.last?.amountTaken ?? 0.0)))
//        chartData.points.append(( "Sunday", Double(filtered7.last?.amountTaken ?? 0.0)))
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//        refresh = false
//        }
//        
//    }
//}
//struct HabitWeekChartView: View {
//
//    @Binding var week: Week
//    @State var chartData = ChartData(values: [("", 0.0)])
//
//    @State var refresh = false
//    var body: some View {
//        ZStack {
//            Color.clear
//                .onAppear() {
//
//                    chartData = ChartData(values: [( "Monday", Double(week.mon.habit.count)), ("Tuesday", Double(week.tue.habit.count)), ("Wednesday", Double(week.wed.habit.count))])
//
//                    chartData.points.append(("Thursday", Double(week.thur.habit.count)))
//                    chartData.points.append(("Friday", Double(week.fri.habit.count)))
//                    chartData.points.append(("Saturday", Double(week.sat.habit.count)))
//                    chartData.points.append(("Sunday", Double(week.sun.habit.count)))
//                }
//            BarChartView(data: $chartData, title: "Score", legend: "", refresh: $refresh)
//
//        }
//    }
//}
struct DayChartView: View {
    @State var title: String
    @Binding var chartData: ChartData
    @Binding var refresh: Bool 
    var body: some View {
        ZStack {
            if !refresh {
            BarChartView(data: $chartData , title: title, legend: "", refresh: $refresh)
        }
    }
}
}

