//
//  HalfCircleView.swift
//  HalfCircleView
//
//  Created by Andreas on 8/3/21.
//

import SwiftUI

struct HalvedCircularBar: View {
    
    @Binding var progress: CGFloat
    @Binding var min: CGFloat
    @Binding var max: CGFloat
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.705)
                    .stroke(Color("blue"), lineWidth: 20)
                    .opacity(0.4)
                    .frame(width: 200, height: 200)
                    .rotationEffect(Angle(degrees: -215))
                Circle()
                    .trim(from: min, to: max)
                    .stroke(Color("blue"), lineWidth: 20)
                    .frame(width: 200, height: 200)
                    .rotationEffect(Angle(degrees: -215))
               
                Text("\(Int((self.progress)*100))%")
                    .font(.custom("Poppins-Bold", size: 20, relativeTo: .headline))
                VStack {
                    Spacer()
                    HStack {
                        Text("0")
                            .font(.custom("Poppins-Bold", size: 12, relativeTo: .headline))
                        Spacer()
                        Text("100")
                            .font(.custom("Poppins-Bold", size: 12, relativeTo: .headline))
                   
                    } .padding(.horizontal, 120)
                    
                } .padding(.bottom, 32)
            }
          
        }
    }
    
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation() {
                self.progress += 0.01
                if self.progress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
    }
}

