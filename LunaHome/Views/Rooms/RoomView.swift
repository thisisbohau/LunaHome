//
//  RoomView.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 15.09.22.
//

import SwiftUI

enum EditType{
    case light
    case blind
    case thermostat
}

class DeviceStates: ObservableObject{
    @Published var selectedLight: Light = Light(id: "", state: false, hue: 0, saturation: 0, brightness: 0, type: "", name: "")
    @Published var selectedBlind: Blind = Blind(id: "", name: "", position: 0, closed: false)
    @Published var selectedThermostat: Thermostat = Thermostat(id: "", name: "", setTemp: 0, currentTemp: 0, coolingDevice: false, performance: 0)
    @Published var activeRoom: Room = Room(id: "", name: "", floor: 0, lights: [Light](), blinds: [Blind](), thermostats: [Thermostat](), sensors: [Sensor]())
    @Published var editType: EditType = .blind
    @Published var showEdit: Bool = false
}

struct RoomView: View {
    @Binding var room: Room
    @EnvironmentObject var fetcher : Fetcher
    @EnvironmentObject var states: DeviceStates
    
    @State var showLightOverview: Bool = false
    @State var showBlindOverview: Bool = false
    @State var showOccupied: Bool = false
    @State var currentRoom = Fetcher().data.rooms.first!
    @State var items: [DeviceListEntry] = [DeviceListEntry]()
    
    @State var navItems: [SelectionMenuItem] = [SelectionMenuItem(id: "lights", name: "Lights", iconName: "lightbulb.fill", color: .yellow), SelectionMenuItem(id: "climate", name: "Climate", iconName: "fanblades.fill", color: Color("tadoCold")), SelectionMenuItem(id: "shades", name: "Shades", iconName: "blinds.horizontal.closed", color: Color("blindAccent"))]
    @State var selectedNav: SelectionMenuItem? = nil
    
    
    @State var showGroupBrightnessSelector: Bool = false
    @State var showGroupColorSelector: Bool = false
    @State var showGroupShadeSelector: Bool = false
    @State var selectedGroupBrightness: Int = 0
    @State var selectedGroupColor: RGB = RGB(r: 0, g: 0, b: 0)
    @State var selectedGroupPosition: Int = 0
    
    @State var settingBrightness: Bool = false
    @State var settingColor: Bool = false
    @State var settingLights: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func setup(){
        DispatchQueue.main.async {
            guard let currentRoom = fetcher.data.rooms.first(where: {$0.id == room.id})else{return}

            self.currentRoom = currentRoom
            
            
            items = getFilteredDevices()
            guard let updatedLight = currentRoom.lights.first(where: {$0.id == states.selectedLight.id})else{return}
            states.selectedLight = updatedLight
            
            guard let updatedBlind = currentRoom.blinds.first(where: {$0.id == states.selectedBlind.id})else{return}
            states.selectedBlind = updatedBlind
            
            guard let updatedTado = currentRoom.thermostats.first(where: {$0.id == states.selectedThermostat.id})else{return}
            states.selectedThermostat = updatedTado
        }
    }
    
    func getAvgTemp(devices: [Thermostat]) -> Double{
        return Double(devices.compactMap({$0.currentTemp}).reduce(0, +))/Double(devices.count)
    }
    
    func getFilteredDevices() -> [DeviceListEntry]{
        if selectedNav != nil{
            switch selectedNav!.id{
            case "lights":
                var items = [DeviceListEntry]()
                
                for light in currentRoom.lights{
                    items.append(DeviceListEntry(id: light.id, device: light, type: .light, size:  .small))
                }
                return items
            case "shades":
                var items = [DeviceListEntry]()
                
                for blind in currentRoom.blinds{
                    
                    items.append(DeviceListEntry(id: blind.id, device: blind, type: .blind, size:  .large))
                }
                return items
            case "climate":
                var items = [DeviceListEntry]()
                for tado in currentRoom.thermostats{
                   
                    items.append(DeviceListEntry(id: tado.id, device: tado, type: .tado, size: .large))
                }
                return items
            default:
                return getRoom()
            }
        }else{
            return getRoom()
        }
    }
    func getRoom() -> [DeviceListEntry]{
        var items = [DeviceListEntry]()
        
        for light in currentRoom.lights{
            items.append(DeviceListEntry(id: light.id, device: light, type: .light, size: .small))
            
        }
        
        for blind in currentRoom.blinds{
            
            items.append(DeviceListEntry(id: blind.id, device: blind, type: .blind, size: .small))
        }
        
        for tado in currentRoom.thermostats{
            items.append(DeviceListEntry(id: tado.id, device: tado, type: .tado, size: .large))
        }
        
        return items
    }
    
    func lightDescription() -> (LocalizedStringKey, Bool){
        guard let room = fetcher.data.rooms.first(where: {$0.id == room.id})else{return ("", false)}
        let count = room.lights.filter({$0.state}).count
       
            return ("\(count) light(s)", count > 0 ? true : false)
       
    }
    func blindDescription() -> (LocalizedStringKey, Bool){
        guard let room = fetcher.data.rooms.first(where: {$0.id == room.id})else{return ("", false)}
        let count = room.blinds.filter({$0.closed}).count

            return ("\(count) blind(s)",  count > 0 ? true : false)
    
    }
    func allOff(){
        Task{
            settingLights = true
//            await SceneKit().roomOffAsync(room: room)
            settingLights = false
        }
        
        
    }
    var roomSelector: some View{
        ScrollViewReader{proxy in
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(fetcher.data.rooms){room in
                        Button(action: {
                            states.activeRoom = room
                            withAnimation(.linear){
                                proxy.scrollTo(room.id, anchor: .leading)
                            }
                            
                        }){
                            Text(room.name)
                                .padding([.leading, .trailing], 13)
                                .padding([.top, .bottom], 7)
                                .foregroundStyle(states.activeRoom.id == room.id ? .primary : .secondary)
                                .foregroundColor(states.activeRoom.id == room.id ? .white : .secondary)
                                .font(states.activeRoom.id == room.id ? .title2.bold() : .body)
                                .cornerRadius(30)
                        }
                    }
                    Spacer(minLength: 150)
                }
            }
        }
    }
    
    var background: some View{
//            Image(room.id.description)
        Image("IMG_0170")
            .resizable()
            .scaledToFill()
//                .overlay(
//                    VStack{
//                        Spacer()
//                        HStack{
//                            Spacer()
//                        }
//                    }
//                        .background(.regularMaterial)
//                )
                .ignoresSafeArea()
        
    
    }
    
    
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: Int(3))
    
    func editLight(light: Light){
        states.editType = .light
        states.selectedLight = light
        states.showEdit = true
    }
    func editBlind(blind: Blind){
        states.editType = .blind
        states.selectedBlind = blind
        states.showEdit = true
    }
    func editTado(tado: Thermostat){
        states.editType = .thermostat
        states.selectedThermostat = tado
        states.showEdit = true
    }
    
    var climateActions: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(String(format: "%.1f", getAvgTemp(devices: room.thermostats)))°")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Inside Avg.")
                                .font(.caption)
                        }
                        .foregroundStyle(.primary)
                        .foregroundColor(.primary)
                    }.padding(.leading)
                
                Spacer()
            }.padding(.top)
        }
    }
    
    var blindActions: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Button(action: {
                    Task{
//                        await BlindKit().toggleFloor(setTo: !blindDescription().1, blinds: room.blinds)
                    }
                }){
                    HStack{
                        VStack(alignment: .leading){
                            Text(blindDescription().0)
                                .font(.headline)
                                .fontWeight(.bold)
                            Text(blindDescription().1 ? "Close All" : "Open All")
                                .font(.caption)
                        }
                        .foregroundStyle(.primary)
                        .foregroundColor(.primary)
                    }.padding(.leading)
                }
                
                Button(action: {
                    showGroupShadeSelector.toggle()
                }){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Move All")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Select Position")
                                .font(.caption)
                        }
                        
                    }
                    .padding(.leading)
                    .foregroundStyle(.primary)
                    .foregroundColor(.primary)
                    
                }
                
                Spacer()
            }.padding(.top)
        }
    }
    
    var lightActions: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Button(action: {allOff()}){
                    HStack{
                        if settingLights{
                            ProgressView()
                                .progressViewStyle(.circular)
                                .padding(10)
                        }
                        
                        VStack(alignment: .leading){
                            Text(lightDescription().0)
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Turn Off")
                                .font(.caption)
                        }
                        .foregroundStyle(.primary)
                        .foregroundColor(.primary)
                        
                        
                        
                    }.padding(.leading)
                }
                
                Button(action: {showGroupBrightnessSelector.toggle()}){
                    HStack{
                        if settingBrightness{
                            ProgressView()
                                .progressViewStyle(.circular)
                                .padding(10)
                        }
                        
                        VStack(alignment: .leading){
                            Text("Dimm All")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Select Brightness")
                                .font(.caption)
                        }
                        
                    }
                    .padding(.leading)
                    .foregroundStyle(.primary)
                    .foregroundColor(.primary)
                    
                }
                if room.lights.contains(where: {$0.hue != 0}){
                    Button(action: {showGroupColorSelector.toggle()}){
                        HStack{
                            if settingColor{
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .padding(10)
                            }
                            
                            VStack(alignment: .leading){
                                Text("Color Sync")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Select Color")
                                    .font(.caption)
                            }
                            
                        }
                        .padding(.leading)
                        .foregroundStyle(.primary)
                        .foregroundColor(.primary)
                        
                    }
                }
                
                Spacer()
            }.padding(.top)
        }
    }
    var body: some View {
        ZStack{
            background

            ScrollView{
                if selectedNav != nil{
                    HStack{
                        Text(selectedNav?.name ?? "")
                            .font(.title2.bold())
                            .padding([.top, .bottom], 7)
                            .padding(.top, 30)
                            .padding([.leading, .trailing], 13)
                        Spacer()
                    }
                   

                }else{
                    roomSelector
                        .padding(.top, 30)
                }
               
                
                SelectionMenu(items: $navItems, selected: $selectedNav)
                    .padding(.leading)
                
//                statusArea
//                    .padding()
                
                switch selectedNav?.id ?? ""{
                case "lights":
                    lightActions
                    
                case "shades":
                    blindActions
                case "climate":
                    climateActions
                default:
                    Text("")
                }
                DeviceList(items: $items)
                
            }
//            .padding()
            .onChange(of: selectedNav?.id, perform: {_ in setup()})
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
            .animation(.linear, value: selectedNav?.id)
        }
//        .ignoresSafeArea()
        .onAppear(perform: {
            setup()
        })
        .onChange(of: room.id, perform: {_ in setup()})
//        .onChange(of: fetcher, perform: {_ in setup()})
        .sheet(isPresented: $showGroupBrightnessSelector){
//            GroupBrightnessSelector(setTo: $selectedGroupBrightness, show: $showGroupBrightnessSelector)
        }
        .onChange(of: showGroupBrightnessSelector, perform: {_ in
            if !showGroupBrightnessSelector{
                Task{
                    settingBrightness = true
//                    await LightKit().dimmAll(lights: room.lights, brightness: selectedGroupBrightness)
                    settingBrightness = false
                }
            }
        })
        .sheet(isPresented: $states.showEdit){
            if states.editType == .blind{
                BlindControl(blind: $states.selectedBlind)
                
            }else if states.editType == .light{
                LightControl(light: $states.selectedLight)
            }else{
                ThermostatControl(thermostat: $states.selectedThermostat)
            }
        }
        .onReceive(timer, perform: {_ in
            if let room = fetcher.data.rooms.firstIndex(where: {$0.lights.contains(where: {$0.id == states.selectedLight.id})}){
                fetcher.data.rooms[room].lights.removeAll(where: {$0.id == states.selectedLight.id})
                fetcher.data.rooms[room].lights.append(states.selectedLight)
            }
            
            if let room = fetcher.data.rooms.firstIndex(where: {$0.blinds.contains(where: {$0.id == states.selectedBlind.id})}){
                fetcher.data.rooms[room].blinds.removeAll(where: {$0.id == states.selectedBlind.id})
                fetcher.data.rooms[room].blinds.append(states.selectedBlind)
            }
            
            if let room = fetcher.data.rooms.firstIndex(where: {$0.thermostats.contains(where: {$0.id == states.selectedThermostat.id})}){
                fetcher.data.rooms[room].thermostats.removeAll(where: {$0.id == states.selectedThermostat.id})
                fetcher.data.rooms[room].thermostats.append(states.selectedThermostat)
            }
            
            setup()
        })
        
//        .sheet(isPresented: $showGroupColorSelector){
//            GroupColorSelector(setTo: $selectedGroupColor, show: $showGroupColorSelector)
//        }
//        .sheet(isPresented: $showGroupShadeSelector){
//           GroupBrightnessSelector(setTo: $selectedGroupPosition, show: $showGroupShadeSelector)
//        }
//        .onChange(of: showGroupShadeSelector, perform: {_ in
//            if !showGroupShadeSelector{
//                Task{
//                    await BlindKit().setAllTo(position: selectedGroupPosition, blinds: room.blinds)
//                }
//            }
//        })
//        .onChange(of: showGroupColorSelector, perform: {_ in
//            if !showGroupColorSelector{
//                Task{
//                    settingColor = true
//                    await LightKit().setColorAll(lights: room.lights.filter({$0.isHue}), color: selectedGroupColor)
//                    settingColor = false
//                }
//            }
//        })
    }
}
//
//struct RoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomView()
//    }
//}
