//
//  GasView.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 27/01/2023.
//

import SwiftUI

struct GasView: View {
    @FetchRequest(sortDescriptors: []) private var categories: FetchedResults<CategoryModel>
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        VStack {
            
        }
    }
    func saveToDB(tool: Tool) {
//        let toolModel = ToolModel(context: viewContext)
//        toolModel.name = tool.rawValue
//        toolModel.kilometers = Int16(tool.maintenanceTool.kilometers)
//        toolModel.months = Int16(tool.maintenanceTool.months)
//        toolModel.image = tool.image
//        
//        do {
//            try viewContext.save()
//        } catch {
//            print("Having problem with saving data")
//        }
    }
}

struct GasView_Previews: PreviewProvider {
    static var previews: some View {
        GasView()
            .environment(\.managedObjectContext, Repository.shared.persistentContainer.viewContext)
    }
}
