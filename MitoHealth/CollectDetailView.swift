//
//  CollectDetailView.swift
//  CollectDetailView
//
//  Created by Andreas on 8/5/21.
//

import SwiftUI

struct CollectDetailView: View {
    @Binding var habit: Habit
    @State var showEditView = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
            Button(action: {
                habit.data.append(UserData(id: UUID().uuidString, type: .Health, title: "", text: "", date: Date(), data: 0.0))
            }) {
                Image(systemSymbol: .plus)
                    .frame(width: 75, height: 75)
                    .padding()
            }
                
            } .padding()
            HStack {
            Text("Title of Data:")
                .font(.custom("Montserrat", size: 18))
                Spacer()
            } .padding()
           
                TextField("Title", text: $habit.title)
                    .font(.custom("Montserrat Bold", size: 18))
                    .padding(.vertical)
                    .submitLabel(.next)
                    .padding()
            
            List {
                ForEach($habit.data, id: \.self) { $data in
                    NavigationLink(destination:  CollectEditView(userData: $data)) {
                        Text(data.title == "" ? "No Title" : data.title)
                            .padding()
                    }
                 
                }
            }
            
        }
    }
}


