//
//  MediumTemplate.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 26.08.22.
//

import SwiftUI

struct MediumTemplate: View {
    @EnvironmentObject var data: Fetcher
    var proxy: CGSize
    var type: DeviceType
    var device: Any
    
    @State var deviceLarge: CGSize = CGSize(width: 0, height: 0)
    @State var spacer: CGFloat = 10
    
    func getBoxSizes(proxy: CGSize){
        deviceLarge = DeviceItemCalculator().getDeviceLargeSize(proxy: proxy)
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
            return .yellow
        }
    }

    func getTempDisplay(device: Any) -> String{
        let tado = device as! Thermostat
        let value = "\(String(format: "%.1f", tado.currentTemp))°"
        return value.replacingOccurrences(of: ".", with: ",")
    }
    
    var tado: some View{
        HStack{
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Text(getTempDisplay(device: device))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .onCondition(getTado(device: device).coolingDevice){view in
                                view.foregroundColor(Color("tadoCold"))
                        }
                        .onCondition(!getTado(device: device).coolingDevice){view in
                            view.foregroundColor(.orange)
                        }
                       
                    
                        .offset(x: -4, y: -4)
                    Spacer()
                    
                        Image(systemName: "battery.75")
                            .font(.callout)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green, .gray)
                            .foregroundColor(Color("tadoCold"))
                            .offset(x: 7)
                  
                }
                
                Spacer()
                
                //Device Name and short Status
                Text((device as! Thermostat).name)
                    .foregroundColor(getTado(device: device).performance > 0 ? .black : .white)
                Text(getTado(device: device).performance > 0 ? String(localized: "\(getTado(device: device).coolingDevice ? "Kühlen" : "Heizen") Auf \(Int(getTado(device: device).setTemp))°C") : "Aus")
                    .onCondition(getTado(device: device).performance > 0, transform: {view in
                        view.foregroundColor(.gray)
                    })
                    .onCondition(getTado(device: device).performance <= 0, transform: {view in
                        view.foregroundStyle(.secondary)
                    })
                
                    .font(.caption)
            }
            Spacer()
        }
    }
    var blind: some View{
        HStack{
            VStack(alignment: .leading){
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
                        .offset(x: -9, y: -4)
                    Spacer()
                }
                Spacer()
                
                //Device Name and short Status
                Text((device as! Blind).name)
                    .foregroundColor(getBlindStatus(blind: device as! Blind) ? .black : .white)
                Text(getBlindStatus(blind: device as! Blind) ? String(localized: "\(Int(getBlind(device: device).position))% Geöffnet") : "Geschlossen")
                    .onCondition(getBlindStatus(blind: device as! Blind), transform: {view in
                        view.foregroundColor(.gray)
                    })
                    .onCondition(!getBlindStatus(blind: device as! Blind), transform: {view in
                        view.foregroundStyle(.secondary)
                    })
                    
                    .font(.caption)
            }
            
            Spacer()
            //Postion Gauge
            if getBlindStatus(blind: device as! Blind){
                GeometryReader{gaugeProxy in
                    ZStack(alignment: .bottom){
                        VStack{
                            Spacer()
                        }
                        .frame(width: 7, height: gaugeProxy.size.height)
                        .background(Color.gray.opacity(0.3))
                        
                        VStack{
                            Spacer()
                        }
                        .frame(width: 7, height: gaugeProxy.size.height/100*CGFloat(getBlind(device: device).position))
                        .background(Color.teal)
                    }
                }.frame(width: 3).cornerRadius(3).padding(.trailing, 2)
            }
        }
    }
    var light: some View{
        HStack{
            VStack(alignment: .leading){
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
                        .offset(x: -9, y: -4)
                    Spacer()
                }
                Spacer()
                
                //Device Name and short Status
                Text((device as! Light).name)
                    .foregroundColor(getLight(device: device).state ? .black : .white)
                Text(getLight(device: device).state ? String(localized: "\(Int(getLight(device: device).brightness))% Helligkeit") : "Ausgeschaltet")
                    .onCondition(getLight(device: device).state, transform: {view in
                        view.foregroundColor(.gray)
                    })
                    .onCondition(!getLight(device: device).state, transform: {view in
                        view.foregroundStyle(.secondary)
                    })
                    
                    .font(.caption)
            }
            
            Spacer()
            //Brightness Gauge
            if getLight(device: device).state{
                GeometryReader{gaugeProxy in
                    ZStack(alignment: .bottom){
                        VStack{
                            Spacer()
                        }
                        .frame(width: 7, height: gaugeProxy.size.height)
                        .background(Color.gray.opacity(0.3))
                        
                        VStack{
                            Spacer()
                        }
                        .frame(width: 7, height: gaugeProxy.size.height/100*CGFloat(getLight(device: device).brightness))
                        .background(getLightAccent(light: getLight(device: device)))
                    }
                }.frame(width: 3).cornerRadius(3).padding(.trailing, 2)
            }
        }
    }
    
    var body: some View {
        VStack{
            switch type{
            case .light:
                light
                    .padding()
                    .onCondition(getLight(device: device).state, transform: {view in
                        view.background(Color("DeviceFill"))
                    })
                    .onCondition(!getLight(device: device).state, transform: {view in
                        view.background(.ultraThinMaterial)
                    })
            case .blind:
                blind
                    .padding()
                    .onCondition(getBlindStatus(blind: device as! Blind), transform: {view in
                        view.background(Color("DeviceFill"))
                    })
                    .onCondition(!getBlindStatus(blind: device as! Blind), transform: {view in
                        view.background(.ultraThinMaterial)
                    })
            case .tado:
                tado
                    .padding()
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
            .frame(width: deviceLarge.width, height: deviceLarge.height)
            .cornerRadius(19)
            .onAppear(perform: {
                getBoxSizes(proxy: proxy)
            })
//            .padding()
            
    }
}
//
//struct MediumTemplate_Previews: PreviewProvider {
//    static var previews: some View {
//        MediumTemplate()
//    }
//}
