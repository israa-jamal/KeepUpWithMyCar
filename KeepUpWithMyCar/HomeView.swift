//
//  HomeView.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 26/01/2023.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(sortDescriptors: []) private var toolsModel: FetchedResults<UserEntry>
    @Environment(\.managedObjectContext) private var viewContext
    @State var text: String = "12000"
    @FocusState private var focusedField: Field?

    private let numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.maximumIntegerDigits = 3
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()
                ScrollView {
                    VStack() {
                        contentView
                    }
                }
            }
            .foregroundColor(.blue)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(Color("white"))
    }
    
    var contentView: some View {
        VStack {
            headerView
            mainView
        }
    }
    
    var mainView: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Maintenance parts state")
                    .foregroundColor(Color("black"))
                    .fontWeight(.heavy)
                Spacer()
            }
            sectionView(text: "Must change", color: .red)
            
            Grid(alignment: .leading) {
                GridRow {
                    toolView(text: "Air", color: .yellow)
                    toolView(text: "Air", color: .yellow)
                    toolView(text: "Air", color: .yellow)
                    toolView(text: "Air", color: .yellow)
                }
            }.padding(.horizontal)
            sectionView(text: "Coming up soon", color: .orange)
            
            Grid() {
                GridRow {
                    toolView(text: "Air", color: .cyan)
                    toolView(text: "Air", color: .cyan)
                }
                GridRow {
                    toolView(text: "Air", color: .cyan)
                    toolView(text: "Air", color: .cyan)
                }
            }
            
            sectionView(text: "Still have time", color: .green)
            
            Grid() {
                GridRow {
                    toolView(text: "Air", color: .pink)
                    toolView(text: "Air", color: .pink)
                    toolView(text: "Air", color: .yellow)
                    toolView(text: "Air", color: .pink)
                    toolView(text: "Air", color: .pink)
                }
                GridRow {
                    toolView(text: "Air", color: .pink)
                    toolView(text: "Air", color: .pink)
                    toolView(text: "Air", color: .pink)
                    toolView(text: "Air", color: .pink)
                    toolView(text: "Air", color: .yellow)
                }
            }
        }
    }
    
    func toolView(text: String, color: Color) -> some View {
        return VStack {
            HStack {
                Text(text)
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color("black"))
                    .padding()
                
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
    
    func sectionView(text: String, color: Color) -> some View {
        return ZStack {
            Rectangle()
                .foregroundColor(color)
                HStack {
                    Text(text)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("white"))
                        .padding()
                    Spacer()
                }
        }
    }
    
    var headerView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
            VStack {
                HStack {
                    Text("Keep up with my car")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        .foregroundColor(Color("white"))
                        .padding()
                    
                    Spacer()
                    Image("car")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 5)
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color("white"))
                        .frame(height: 45)
                        .padding(.horizontal, 16)
                    TextField("Enter Current Kilometers", value: $text, formatter: numberFormatter)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focusedField = nil
                                }
                            }
                        }
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .font(.title)
                        .fontWeight(.medium)
                        .frame(height: 45)
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 10)
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
