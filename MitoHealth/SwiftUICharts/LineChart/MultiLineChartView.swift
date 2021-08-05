//
//  File.swift
//  
//
//  Created by Samu András on 2020. 02. 19..
//

import SwiftUI

 struct MultiLineChartView: View {
    
    @Binding var data: [MultiLineChartData]
    @Binding  var refresh: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
     var title: String
     var legend: String?
     var style: ChartStyle =  Styles.lineChartStyleOne
     var darkModeStyle: ChartStyle = Styles.lineChartStyleOne
     var formSize:CGSize = ChartForm.large
     var dropShadow: Bool = false
     var cornerImage: Image = Image(systemName: "")
     var valueSpecifier:String = "%.1f"
    
    @State  var touchLocation:CGPoint = .zero
    @State  var showIndicatorDot: Bool = false
    @State  var currentValue: Double = 2 {
        didSet{
            if (oldValue != self.currentValue && showIndicatorDot) {
                HapticFeedback.playSelection()
            }
            
        }
    }
    
    var globalMin:Double {
        if let min = data.flatMap({$0.onlyPoints()}).min() {
            return min
        }
        return 0
    }
    
    var globalMax:Double {
        if let max = data.flatMap({$0.onlyPoints()}).max() {
            return max
        }
        return 0
    }
    
    var frame = CGSize(width: 180, height: 120)
     var rateValue: Int?
 
    
     var body: some View {
        ZStack(alignment: .center){
            if !refresh {
            RoundedRectangle(cornerRadius: 20)
                .fill(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
                .frame(width: frame.width, height: 240, alignment: .center)
                .shadow(radius: self.dropShadow ? 8 : 0)
            VStack(alignment: .leading){
                if(!self.showIndicatorDot){
                    VStack(alignment: .leading, spacing: 8){
                        Text(self.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                        if (self.legend != nil){
                            Text(self.legend!)
                                .font(.callout)
                                .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                        }
                        HStack {
                            if (rateValue ?? 0 >= 0){
                                Image(systemName: "arrow.up")
                            }else{
                                Image(systemName: "arrow.down")
                            }
                            Text("\(rateValue ?? 0)%")
                        }
                    }
                    .transition(.opacity)
                    .animation(.easeIn(duration: 0.1))
                    .padding([.leading, .top])
                }else{
                    HStack{
                        Spacer()
                        Text("\(self.currentValue, specifier: self.valueSpecifier)")
                            .font(.system(size: 41, weight: .bold, design: .default))
                            .offset(x: 0, y: 30)
                        Spacer()
                    }
                    .transition(.scale)
                }
                Spacer()
                GeometryReader{ geometry in
                    ZStack{
                        ForEach(0..<self.data.count) { i in
                            Line(data: self.data[i],
                                 frame: .constant(geometry.frame(in: .local)),
                                 touchLocation: self.$touchLocation,
                                 showIndicator: self.$showIndicatorDot,
                                 minDataValue: .constant(self.globalMin),
                                 maxDataValue: .constant(self.globalMax),
                                 showBackground: false,
                                 gradient: self.data[i].getGradient(),
                                 index: i)
                        }
                    }
                }
                .frame(width: frame.width, height: frame.height + 30)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: 0, y: 0)
            }.frame(minWidth:self.formSize.width,
                    maxWidth: self.formSize.width,
                    minHeight:self.formSize.height,
                    maxHeight:self.formSize.height)
        }
        }
        .gesture(DragGesture())
        
//        .onChanged({ value in
//            self.touchLocation = value.location
//            self.showIndicatorDot = true
//            self.getClosestDataPoint(toPoint: value.location, width:self.frame.width, height: self.frame.height)
//        })
//            .onEnded({ value in
//                self.showIndicatorDot = false
//            })
//        )
//    }
//
//    @discardableResult func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
//        let points = self.data.onlyPoints()
//        let stepWidth: CGFloat = width / CGFloat(points.count-1)
//        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
//
//        let index:Int = Int(round((toPoint.x)/stepWidth))
//        if (index >= 0 && index < points.count){
//            self.currentValue = points[index]
//            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
//        }
//        return .zero
//    }
}
 }
