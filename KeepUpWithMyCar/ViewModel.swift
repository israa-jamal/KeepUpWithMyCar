//
//  viewModel.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 26/01/2023.
//

import SwiftUI
import CoreData

struct ViewModel {
    let toolsTypes: [ToolTypes]
    
    init() {
        toolsTypes = ToolTypes.allCases
    }
}

enum ToolTypes: String, CaseIterable {
    case liquids = "Liquids"
    case filters = "Filters"
    case belts = "Belts"
    case parts = "Parts"
    case other = "Other"
    
    var color: Color {
        switch self {
        case .liquids:
            return .orange
        case .filters:
            return .green
        case .belts:
            return .red
        case .parts:
            return .blue
        case .other:
            return .purple
        }
    }
    
    var colorString: String {
        switch self {
        case .liquids:
            return "orange"
        case .filters:
            return "green"
        case .belts:
            return "red"
        case .parts:
            return "blue"
        case .other:
            return "purple"
        }
    }
    
    var image: String {
        switch self {
        case .liquids:
            return "oils"
        case .filters:
            return "filters"
        case .belts:
            return "belts"
        case .parts:
            return "car-service"
        case .other:
            return "tires"
        }
    }
    
    var tools: [Tool] {
        switch self {
        case .liquids:
            return [.engineOil, .transmissionOil, .powerOil, .brakeFluid, .coolant]
        case .filters:
            return [.airFilter, .oilFilter, .gasFilter, .airConditionerFilter]
        case .belts:
            return [.timingBelt, .powerBelt, .airConditionerBelt]
        case .parts:
            return [.sparkPlug, .frontBrake, .backBrake]
        case .other:
            return [.tires]
        }
    }
}

struct MaintenanceTool: Hashable {
    let name: String
    var months: Int = 0
    var kilometers: Int = 0
}

enum Tool: String {
    case engineOil = "Engine Oil"
    case transmissionOil = "Transmission Oil"
    case coolant = "Coolant"
    case powerOil = "Power Steering Fluid"
    case brakeFluid = "Brake Fluid"
    
    case airFilter = "Air Filter"
    case oilFilter = "Oil Filter"
    case gasFilter = "Gas Filter"
    case airConditionerFilter = "Air Conditioner Filter"
    
    case timingBelt = "Timing Belt"
    case powerBelt = "Power Belt"
    case airConditionerBelt = "Air Conditioner Belt"
    
    case sparkPlug = "Spark Plug"
    case tires = "Tires"
    case frontBrake = "Front Brake Pad"
    case backBrake = "Back Brake Pad"
    
    var maintenanceTool: MaintenanceTool {
        switch self {
        case .engineOil:
            return MaintenanceTool(name: self.rawValue, months: 8, kilometers: 10000)
        case .transmissionOil:
            return MaintenanceTool(name: self.rawValue, months: 24, kilometers: 40000)
        case .coolant:
            return MaintenanceTool(name: self.rawValue, months: 24)
        case .powerOil:
            return MaintenanceTool(name: self.rawValue, months: 24, kilometers: 40000)
        case .brakeFluid:
            return MaintenanceTool(name: self.rawValue, months: 24, kilometers: 40000)
        case .airFilter:
            return MaintenanceTool(name: self.rawValue, months: 12, kilometers: 10000)
        case .oilFilter:
            return MaintenanceTool(name: self.rawValue, months: 8, kilometers: 10000)
        case .gasFilter:
            return MaintenanceTool(name: self.rawValue, months: 24, kilometers: 40000)
        case .airConditionerFilter:
            return MaintenanceTool(name: self.rawValue, months: 12)
        case .timingBelt:
            return MaintenanceTool(name: self.rawValue, months: 48, kilometers: 45000)
        case .powerBelt:
            return MaintenanceTool(name: self.rawValue, months: 48, kilometers: 45000)
        case .airConditionerBelt:
            return MaintenanceTool(name: self.rawValue, months: 48, kilometers: 45000)
        case .sparkPlug:
            return MaintenanceTool(name: self.rawValue, kilometers: 20000)
        case .tires:
            return MaintenanceTool(name: self.rawValue, months: 60, kilometers: 60000)
        case .frontBrake:
            return MaintenanceTool(name: self.rawValue, kilometers: 15000)
        case .backBrake:
            return MaintenanceTool(name: self.rawValue, kilometers: 45000)
        }
    }
    
    var image: String {
        switch self {
        case .engineOil:
            return "engine-oil"
        case .transmissionOil:
            return "transmission-oil"
        case .coolant:
            return "coolant"
        case .powerOil:
            return "power-oil"
        case .brakeFluid:
            return "brake-fluid"
        case .airFilter:
            return "air-filter"
        case .oilFilter:
            return "oil-filter"
        case .gasFilter:
            return "gas-filter"
        case .airConditionerFilter:
            return "air-conditioner-filter"
        case .timingBelt:
            return "timing-belt"
        case .powerBelt:
            return "power-belt"
        case .airConditionerBelt:
            return "fan-belt"
        case .sparkPlug:
            return "spark-plug"
        case .tires:
            return "tire"
        case .frontBrake:
            return "front-pad"
        case .backBrake:
            return "back-pad"
        }
    }
}
