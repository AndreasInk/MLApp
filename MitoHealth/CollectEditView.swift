//
//  CollectEditView.swift
//  CollectEditView
//
//  Created by Andreas on 8/5/21.
//

import SwiftUI
import SFSafeSymbols
struct CollectEditView: View {
    @Binding var userData: UserData
    @State var types = [String]()
    @State var addTag = false
    @State var tag = ""
    var body: some View {
        VStack {
//            HStack {
//            Button(action: {
//                if addTag {
//                    if !tag.isEmpty {
//                        types.append(tag)
//
//                    UserDefaults.standard.set(types, forKey: "types")
//                }
//                }
//                addTag.toggle()
//
//            }
//            ) {
//                Text(addTag ? "Save Tag" : "Add Tag")
//                    .font(.custom("Montserrat Bold", size: 12))
//                .multilineTextAlignment(.leading)
//
//                    .padding()
//            }
//                Spacer()
//                if addTag {
//                    TextField("Tag Name", text: $tag)
//                        .font(.custom("Montserrat Bold", size: 12))
//                    .multilineTextAlignment(.leading)
//                    .padding()
//
//                } else {
//
//                }
//            } .padding()
            HStack {
            Text("Title of Data:")
                .font(.custom("Montserrat", size: 18))
                
                .onAppear() {
                    types.append(contentsOf: DataType.allCases.map{$0.rawValue})
                }
                Spacer()
            }  .padding()
                TextField("Title", text: $userData.title)
                    .font(.custom("Montserrat Bold", size: 18))
                    .padding(.vertical)
                    .submitLabel(.next)
                    .padding()
//        HStack {
//            Menu {
//                ForEach(types, id: \.self) { type in
//                    Button(action: {
//                        userData.type = DataType(rawValue: type) ?? .Habit
//                        userData.title = tag
//                    }) {
//                        Text(type)
//                    }
//                }
//            } label: {Text(userData.type == .Habit ? userData.title : userData.type.rawValue).font(.custom("Montserrat Bold", size: 18))}
//            Spacer()
//        }
           
            
        HStack {
            Text("Data:")
            
            Spacer()
        } .padding()
      
        TextField("Data", value: $userData.data, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .padding()
            .padding(.bottom)
            
            DatePicker("", selection: $userData.date, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
            Spacer()
        }
    }
}


