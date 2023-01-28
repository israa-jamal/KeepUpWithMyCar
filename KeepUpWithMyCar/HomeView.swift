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
    @State var text: String = ""
    @FocusState private var focusedField: Field?
    @State private var maintenanceCategories: [MaintenanceCategory] = []

    private let numberFormatter: NumberFormatter
    
    let columns = [
        GridItem(.adaptive(minimum: 1))
    ]
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.maximumIntegerDigits = 3
        text = "\(Repository.kilometers)"
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
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let array = toolsModel.compactMap({Maintenance(model: $0)})
        let states = Array(Set(array.compactMap({$0.state})))
        maintenanceCategories = states.compactMap({ state in
            MaintenanceCategory(state: state, maintenance: array.filter({$0.state == state}))
        })
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
            
            ForEach(maintenanceCategories, id: \.self) { category in
                sectionView(text: category.state.title, color: category.state.color)
                let maintenance = maintenanceCategories.filter({$0.state == category.state}).first?.maintenance ?? []
                GridView(maintenance: maintenance)
            }
        }
    }

    func sectionView(text: String, color: Color) -> some View {
        return ZStack {
            Rectangle()
                .foregroundColor(color)
                .frame(height: 45)
            HStack {
                Text(text)
                    .font(.title3)
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
                    TextField("Enter Current Kilometers", text: $text)
                        .focused($focusedField, equals: .kilometers)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focusedField = nil
                                    Repository.setKilometers(Int(text) ?? 0)
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

struct MaintenanceCategory: Hashable {
    let state: ChangeState
    let maintenance: [Maintenance]
}

struct Maintenance: Hashable {
    let tool: Tool
    let remainingDays: Int?
    let remainingKilometers: Int?
    let state: ChangeState
    
    init(model: UserEntry) {
        tool = Tool(rawValue: model.tool!)!
        let date = model.date ?? Date()
        let kilometers = Int(model.kilometers)
        remainingDays = getRemainingDays(date: date, tool: tool)
        remainingKilometers = getRemainingKilometers(km: kilometers, tool: tool)
        state = getState(days: remainingDays, km: remainingKilometers)
    }
}

func getRemainingDays(date: Date, tool: Tool) -> Int? {
    if tool.maintenanceTool.months == 0 {
        return nil
    }
    let passedDays = Calendar.current.dateComponents([.day], from: date, to: .now).day ?? 0
    return (tool.maintenanceTool.months * 30 - passedDays)
}

func getRemainingKilometers(km: Int, tool: Tool) -> Int? {
    if tool.maintenanceTool.kilometers == 0 {
        return nil
    }
    let passedKilos = abs(Repository.kilometers - km)
    return tool.maintenanceTool.kilometers - passedKilos
}

func getState(days: Int?, km: Int?) -> ChangeState {
    if let days, let km {
        if days < 1 || km < 1 {
            return .overdo
        } else if days < 32 || km < 500 {
            return .must
        } else if days < 95 || km < 3000 {
            return .next
        } else {
            return .noNeed
        }
    } else if let days {
        if days < 1 {
            return .overdo
        } else if days < 32 {
            return .must
        } else if days < 95 {
            return .next
        } else {
            return .noNeed
        }
    } else if let km {
        if km < 1 {
            return .overdo
        } else if km < 500 {
            return .must
        } else if km < 3000 {
            return .next
        } else {
            return .noNeed
        }
    }
    return .overdo
}

enum ChangeState: Int {
    case overdo = 0
    case must = 1
    case next = 2
    case noNeed = 3
    
    var title: String {
        switch self {
        case .overdo:
            return "Overdo"
        case .must:
            return "Must change"
        case .next:
            return "Coming up soon"
        case .noNeed:
            return "Still have time"
        }
    }
    
    var color: Color {
        switch self {
        case .overdo:
            return .red
        case .must:
            return .orange
        case .next:
            return .yellow
        case .noNeed:
            return .green
        }
    }
}

struct GridView: View {
    var tags: [Maintenance]
    @State private var totalHeight = CGFloat.zero
    
    init(maintenance: [Maintenance]) {
        self.tags = maintenance
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.toolView(tool: tag.tool, color: tag.state.color)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func toolView(tool: Tool, color: Color) -> some View {
        return NavigationLink {
            ToolDetail(tool: tool, color: color)
        } label: {
            VStack {
                HStack {
                    Text(tool.rawValue)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color("black"))
                        .padding()
                    
                }
            }
            //        .padding(.all, 5)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(color.opacity(0.2), lineWidth: 1)
            )
        }
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
