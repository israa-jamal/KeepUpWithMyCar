//
//  Repository.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 27/01/2023.
//

import Foundation
import CoreData

class Repository {
    static let shared = Repository()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MaintenanceModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to load data, \(error.localizedDescription)")
            }
        }
    }
    
    func addStaticData() {
//        let types: [ToolTypes] = ToolTypes.allCases
//        for type in types {
//            let category = CategoryModel(context: persistentContainer.viewContext)
//                category.name = type.rawValue
//                category.color = type.colorString
//                category.image = type.image
//            saveContext()
//            for tool in type.tools {
//                category.addToTools(getToolModel(tool: tool))
//                saveContext()
//            }
//        }
    }
    
//    func getToolModel(tool: Tool) -> ToolModel {
//        let toolModel = ToolModel(context: persistentContainer.viewContext)
//        toolModel.name = tool.maintenanceTool.name
//        toolModel.kilometers = Int32(tool.maintenanceTool.kilometers)
//        toolModel.months = Int32(tool.maintenanceTool.months)
//        toolModel.image = tool.image
//        return toolModel
//    }
//
    func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Having problem with saving data")
        }
    }
    
    func deleteAllData() {
        let context = persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntry")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
}
