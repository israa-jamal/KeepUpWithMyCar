//
//  ToolsView.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 26/01/2023.
//

import SwiftUI

struct ToolsView: View {
    
    let viewModel = ViewModel()

    var body: some View {
            NavigationStack {
                VStack(spacing: 0) {
                    Divider()
                    ScrollView {
                        VStack() {
                            toolsTypesListView
                        }
                    }
                }
                .foregroundColor(.blue)
                .navigationTitle("Tools")
                .navigationBarTitleDisplayMode(.inline)
            }
            .accentColor(Color("white"))
    }

    var toolsTypesListView: some View {
        ForEach(viewModel.toolsTypes, id: \.self) { type in
            TypeSectionView(type: type)
            
            ForEach(type.tools, id: \.self) { tool in
                
                NavigationLink {
                    ToolDetail(tool: tool, color: type.color)
                } label: {
                    ToolView(tool: tool, color: type.color, isLast: tool == type.tools.last) {
                        print(tool.rawValue)
                    }
                }
            }
        }
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}

