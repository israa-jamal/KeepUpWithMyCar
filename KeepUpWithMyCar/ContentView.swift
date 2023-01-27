//
//  ContentView.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 10/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var entries: FetchedResults<UserEntry>

    var body: some View {
        VStack {
            tabView
        }
        .onAppear {
//            Repository.shared.addStaticData()
            print(entries)
        }
    }
    
    var tabView: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(selection == 0 ? "car-park-active" : "car-park")
                            .resizable()
                            .aspectRatio(CGSize(width: 20, height: 20), contentMode: .fit)
                        Text("Home")
                            .foregroundColor(Color("black"))
                    }
                }
            
            ToolsView()
                .tabItem {
                    VStack {
                        Image("tools")
                            .resizable()
                            .aspectRatio(CGSize(width: 20, height: 20), contentMode: .fit)
                        Text("Tools")
                            .foregroundColor(Color("black"))
                    }
                }
            
            GasView()
                .tabItem {
                    VStack {
                        Image("settings")
                            .resizable()
                            .aspectRatio(CGSize(width: 20, height: 20), contentMode: .fit)
                        Text("Gas")
                    }
                }
        }.groupBoxStyle(.automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Hello World")
        }
        .padding()
    }
}
