//
//  TypeSectionView.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 26/01/2023.
//

import SwiftUI

struct TypeSectionView: View {
    let type: ToolTypes
    
    init(type: ToolTypes) {
        self.type = type
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(type.color)
                .padding(.top, 20)
                        .cornerRadius(20)
                        .padding(.top, -20)
            HStack {
                Text(type.rawValue)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("white"))
                    .padding()
                
                Spacer()
                Image(type.image)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(.trailing, 5)
            }
        }.frame(height: 75)
    }
}

struct TypeSectionView_Previews: PreviewProvider {
    static var previews: some View {
        TypeSectionView(type: .filters)
            .frame(width: 300, height: 75).previewLayout(.sizeThatFits)
                .padding()
    }
}

struct ToolView: View {
    let tool: Tool
    let color: Color
    let isLast: Bool
    let didPress: () -> ()
    
    init(tool: Tool, color: Color, isLast: Bool, didPress: @escaping () -> ()) {
        self.tool = tool
        self.color = color
        self.isLast = isLast
        self.didPress = didPress
    }
    
    var body: some View {
//        Button {
//            didPress()
//        } label: {
            VStack {
                HStack {
                    Text(tool.rawValue)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color("black"))
                        .padding()
                    
                    Spacer()
                }
                if !isLast {
                    Divider()
                        .background(color.opacity(0.7))
                        .frame(height: 1)
                }
            }
//        }
    }
}

struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        ToolView(tool: .oilFilter, color: .blue, isLast: false, didPress: {})
            .frame(width: 300, height: 50).previewLayout(.sizeThatFits)
                .padding()
    }
}
