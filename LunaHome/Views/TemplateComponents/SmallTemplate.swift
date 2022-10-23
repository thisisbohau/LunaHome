//
//  SmallTemplate.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 26.08.22.
//

import SwiftUI

enum DeviceType{
    case light
    case blind
    case tado
    case window
    case motion
    case overlay
}

struct SmallTemplate: View {
    @EnvironmentObject var data: Fetcher
    var proxy: CGSize
    var type: DeviceType
    var device: Any
    
    @State var deviceSmall: CGSize = CGSize(width: 0, height: 0)
    @State var spacer: CGFloat = 10
    
    func getBoxSizes(proxy: CGSize){
        deviceSmall = DeviceItemCalculator().getDeviceSmallSize(proxy: proxy)
        spacer = DeviceItemCalculator().spacer
    }
    
    func getLight(device: Any) -> Light{
        return device as! Light
    }
    func getBlind(device: Any) -> Blind{
        return device as! Blind
    }
    func getTado(device: Any) -> Thermostat{
        return device as! Thermostat
    }
    func getWindow(device: Any) -> Sensor{
        return device as! Sensor
    }
    
    func getBlindStatus(blind: Blind) -> Bool{
        return blind.position > 3
    }

    func getLightAccent(light: Light) -> Color{
        if light.type == "brightness"{
            if light.hue <= 0{
                return .yellow
            }else{
                return Color(hue: Double(light.hue)/360, saturation: Double(light.saturation/255), brightness: 1)
            }
        }else{
            return Color(hue: Double(light.hue)/360, saturation: Double(light.saturation/255), brightness: 1)
        }
    }

    func getTempDisplay(device: Any) -> String{
        let tado = device as! Thermostat
        let value = "\(String(format: "%.1f", tado.currentTemp))°"
        return value.replacingOccurrences(of: ".", with: ",")
    }
    
    var tado: some View{
        
        HStack{
            Text(getTempDisplay(device: device))
                .font(.callout)
                .fontWeight(.semibold)
                .onCondition(getTado(device: device).coolingDevice){view in
                        view.foregroundColor(Color("tadoCold"))
                }
                .onCondition(!getTado(device: device).coolingDevice){view in
                    view.foregroundColor(Color.orange)
                }
            
            VStack(alignment: .leading){
                //Device Name and short Status
                Spacer()
                //TODO: Add battery manager
               
                    HStack{
                        Image(systemName: "battery.75")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green, .gray)
                        Text("Batterie")
                            .foregroundColor(.gray)
                            .offset(x: -3)
                    }
                    .font(.system(size: 10))
                   
                
                Text((device as! Thermostat).name)
                    .foregroundColor(getTado(device: device).performance > 0 ? .black : .white)
                Text(getTado(device: device).performance > 0 ? String(localized: "\(getTado(device: device).coolingDevice ? "Cooling" : "Heating") To \(Int(getTado(device: device).setTemp))°C") : "Off")
                    .onCondition(getTado(device: device).performance > 0, transform: {view in
                        view.foregroundColor(.gray)
                    })
                    .onCondition(getTado(device: device).performance <= 0, transform: {view in
                        view.foregroundStyle(.secondary)
                    })
                    .font(.caption)
                    .lineLimit(1)
                Spacer()
            }.offset(x: -2)
            Spacer()
        }
    }
    var blind: some View{
        HStack{
            DeviceIcon(type: .blind, device: getBlind(device: device))
                .font(.body)
                .padding(10)
            
                .onCondition(getBlindStatus(blind: device as! Blind), transform: {view in
                    view
                        .background(Color.teal, in: Circle())
                })
                .onCondition(!getBlindStatus(blind: device as! Blind), transform: {view in
                    view
                        .background(.thinMaterial, in: Circle())
                })
                .offset(x: -5)
            
            VStack(alignment: .leading){
                //Device Name and short Status
                Spacer()
                Text((device as! Blind).name)
                    .foregroundColor(getBlindStatus(blind: device as! Blind) ? .black : .white)
                    .font(.callout)
                HStack{
                    Text(getBlindStatus(blind: device as! Blind) ? String(localized: "\(Int(getBlind(device: device).position))%") : "Geschlossen")
                        .onCondition(getBlindStatus(blind: device as! Blind), transform: {view in
                            view.foregroundColor(.gray)
                        })
                        .onCondition(!getBlindStatus(blind: device as! Blind), transform: {view in
                            view
                            
                                .foregroundStyle(.secondary)
                        })
                        .font(.caption)
                        .lineLimit(1)
                    Spacer()
                }
                Spacer()
            }.offset(x: -10)
        }
    }
    
    var light: some View{
            HStack{
                DeviceIcon(type: .light, device: getLight(device: device))
                    .font(.body)
                    .padding(10)
                
                    .onCondition(getLight(device: device).state, transform: {view in
                        view
                            .background(getLightAccent(light: getLight(device: device)), in: Circle())
                    })
                    .onCondition(!getLight(device: device).state, transform: {view in
                        view
                            .background(.thinMaterial, in: Circle())
                    })
                    .offset(x: -5)
                
                VStack(alignment: .leading){
                    //Device Name and short Status
                    Spacer()
                    Text((device as! Light).name)
                        .foregroundColor(getLight(device: device).state ? .black : .white)
                        .font(.callout)
                        .lineLimit(1)
    //                    .minimumScaleFactor(0.8)
                    HStack{
                        Text(getLight(device: device).state ? String(localized: "\(Int(getLight(device: device).brightness))%") : "Ausgeschaltet")
                            .onCondition(getLight(device: device).state, transform: {view in
                                view.foregroundColor(.gray)
                            })
                            .onCondition(!getLight(device: device).state, transform: {view in
                                view
                                    .foregroundStyle(.secondary)
                                
                                
                            })
                            .font(.caption)
                            .lineLimit(1)
                        Spacer()
                    }
                    Spacer()
                }.offset(x: -10)
               
//            Spacer()
        }
    
    }
    
    var body: some View {
        VStack{
            switch type{
            case .light:
                light
                    .padding(10)
                    .onCondition(getLight(device: device).state, transform: {view in
                        view.background(Color("DeviceFill"))
                    })
                    .onCondition(!getLight(device: device).state, transform: {view in
                        view.background(.ultraThinMaterial)
                    })
            case .blind:
                blind
                    .padding(10)
                    .onCondition(getBlindStatus(blind: device as! Blind), transform: {view in
                        view.background(Color("DeviceFill"))
                    })
                    .onCondition(!getBlindStatus(blind: device as! Blind), transform: {view in
                        view.background(.ultraThinMaterial)
                    })
            case .tado:
                tado
                    .padding(10)
                    .onCondition(getTado(device: device).performance > 0, transform: {view in
                        view.background(Color("DeviceFill"))
                    })
                    .onCondition(getTado(device: device).performance <= 0, transform: {view in
                        view.background(.ultraThinMaterial)
                    })
            case .overlay:
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                    }
                }
                .padding(10)
                .background(.ultraThinMaterial)
                
            
            default:
                Text("Error")
            }
        }
            .frame(width: deviceSmall.width, height: deviceSmall.height)
            .cornerRadius(16)
            .onAppear(perform: {
                getBoxSizes(proxy: proxy)
            })
    }
}

//struct SmallTemplate_Previews: PreviewProvider {
//    static var previews: some View {
//        SmallTemplate()
//    }
//}
