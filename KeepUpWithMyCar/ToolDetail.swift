//
//  ToolDetail.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 26/01/2023.
//

import SwiftUI

enum Field: Int, CaseIterable {
    case kilometers
}

struct ToolDetail: View {
    @FetchRequest(sortDescriptors: []) private var toolsModel: FetchedResults<UserEntry>
    @Environment(\.managedObjectContext) private var viewContext
    @State var text: String = ""
    @State var isEditing: Bool = false
    @State var selectedDate = Date()
    @State var buttonTitle: String = ""
    @FocusState private var focusedField: Field?

    let tool: Tool
    let color: Color
    private let numberFormatter: NumberFormatter
    
    init(tool: Tool, color: Color) {
        self.tool = tool
        self.color = color
        numberFormatter = NumberFormatter()
        numberFormatter.maximumIntegerDigits = 3
    }
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(color)
                        .padding(.top, 10)
                        .cornerRadius(10)
                        .padding(.top, -10)
                        .ignoresSafeArea()
                    
                    VStack {
                        Image(tool.image)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(.trailing, 5)
                        
                        Text(tool.rawValue)
                            .font(.system(size: 50))
                            .bold()
                            .foregroundColor(Color("white"))
                            .padding()
                    }
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Button {
                            if isEditing {
                                saveData()
                            }
                            isEditing = !isEditing
                            buttonTitle = isEditing ? "Done" : "Edit"
                        } label: {
                            Text(buttonTitle)
                                .font(.headline)
                                .bold()
                                .foregroundColor(.pink)
                        }
                        .padding()
                        Spacer()
                    }
                }
            }.frame(height: 200)
            if isEditing {
                if tool.maintenanceTool.kilometers > 0 {
                    Spacer()
                    TextField("Enter Kilometers", text: $text)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .kilometers)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focusedField = nil
                                }
                            }
                        }
                        .frame(height: 50)
                        .padding(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(color, lineWidth: 2)
                        )
                        .padding()
                }
                if tool.maintenanceTool.months > 0 {
                    Spacer()
                    DatePicker(selection: $selectedDate, displayedComponents: [.date]) {
                        Text("Date Of Change")
                            .font(.title3)
                            .padding()
                    }
                    .frame(height: 300)
                    .accentColor(color)
                    .datePickerStyle(GraphicalDatePickerStyle())
                }
                Spacer()
            } else {
                
                Text("Needs to be changed every \(tool.maintenanceTool.kilometers) KM\nor every \(tool.maintenanceTool.months) Months")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(10)
                    .fontWeight(.medium)
                    .padding()
                
                Text("Changed at \(text) KM\nin \(selectedDate.formatted())")
                    .foregroundColor(.gray)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(10)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(color, lineWidth: 5)
                    )
                    .padding()
                Spacer()
                
            }
            
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear(perform: handleData)
    }
    
    func handleData() {
        if let entry = toolsModel.first(where: {$0.tool == tool.rawValue}) {
            isEditing = false
            if let date = entry.date {
                selectedDate = date
            }
            let kilometers = Int(entry.kilometers)
            if kilometers > 0 {
                text = kilometers.formatted()
            }
        } else {
            isEditing = true
        }
        buttonTitle = isEditing ? "Done" : "Edit"
    }
    
    func saveData() {
        Repository.shared.delete(tool: tool)
        let entry = UserEntry(context: viewContext)
        entry.tool = tool.rawValue
        entry.kilometers = Int32(text) ?? 0
        entry.date = selectedDate
        Repository.shared.saveContext()
    }
}

struct ToolDetail_Previews: PreviewProvider {
    static var previews: some View {
        ToolDetail(tool: .engineOil, color: .orange)
    }
}
