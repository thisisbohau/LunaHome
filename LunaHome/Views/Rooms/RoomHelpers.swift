//
//  RoomHelpers.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 15.09.22.
//

import Foundation
import SwiftUI

struct SelectionMenuItem: Identifiable{
    var id: String
    var name: String
    var iconName: String
    var color: Color
}
struct SelectionMenu: View {
    @Binding var items: [SelectionMenuItem]
    @Binding var selected: SelectionMenuItem?
    
    var body: some View {
        ScrollViewReader{proxy in
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(items){item in
                        Button(action: {
                            if selected?.id == item.id{
                                selected = nil
                            }else{
                                selected = item
                            }
                            
                        }){
                            HStack{
                                Image(systemName: item.iconName)
                                    .foregroundColor(item.color)
                                Text(item.name)
                                
                            }.font(.callout)
                                .padding([.leading, .trailing], 13)
                                .padding(.trailing, 5)
                                .padding([.top, .bottom], 15)
                                .onCondition(selected?.id != item.id, transform: {view in
                                    view
                                        .background(Capsule(style: RoundedCornerStyle.continuous)
                                            .foregroundStyle(.ultraThinMaterial))
                                })
                                .onCondition(selected?.id == item.id, transform: {view in
                                    view
                                        .background(Capsule(style: RoundedCornerStyle.continuous).foregroundColor(Color("DeviceFill")))
                                        .foregroundColor(.black)
                                })
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

struct DeviceList: View{
    @EnvironmentObject var states: DeviceStates
    @Binding var items: [DeviceListEntry]
    @State var deviceSmall: CGSize = CGSize(width: 0, height: 0)
    @State var deviceLarge: CGSize = CGSize(width: 0, height: 0)
    @State var spacer: CGFloat = 10
    
    func getBoxSizes(proxy: CGSize){
        deviceSmall = DeviceItemCalculator().getDeviceSmallSize(proxy: proxy)
        deviceLarge = DeviceItemCalculator().getDeviceLargeSize(proxy: proxy)
        spacer = DeviceItemCalculator().spacer
        
    }
    func performAction(item: DeviceListEntry){
        switch item.type{
        case .light:
            states.selectedLight = item.device as! Light
            states.editType = .light
            states.showEdit = true
        case .blind:
            states.selectedBlind = item.device as! Blind
            states.editType = .blind
            states.showEdit = true
        case .tado:
            states.selectedThermostat = item.device as! Thermostat
            states.editType = .thermostat
            states.showEdit = true
        default:
            return
        }
    }

    var body: some View {
        GeometryReader{proxy in
            VStack{
                HStack(alignment: .top, spacing: 0){
                    VStack(spacing: 0){
                        ForEach(DeviceItemCalculator().getOddItems(items: items)){item in
                            Button(action: {
                                performAction(item: item)
                            }){
                                if item.size ?? .small == .large{
                                    MediumTemplate(proxy: proxy.size, type: item.type, device: item.device)
                                        .padding([.bottom, .trailing], spacer)
                                }else{
                                    SmallTemplate(proxy: proxy.size, type: item.type, device: item.device)
                                        .padding([.bottom, .trailing], spacer)
                                        
                                }
                            } .buttonStyle(PlainButtonStyle())
                            
                        }
                    }
                    
                    VStack(spacing: 0){
                        ForEach(DeviceItemCalculator().getEvenItems(items: items)){item in
                            Button(action: {
                                performAction(item: item)
                            }){
                                if item.size ?? .small == .large{
                                    MediumTemplate(proxy: proxy.size, type: item.type, device: item.device)
                                        .padding([.bottom, .trailing], spacer)
                                }else{
                                    SmallTemplate(proxy: proxy.size, type: item.type, device: item.device)
                                        .padding([.bottom, .trailing], spacer)
                                }
                            } .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .onAppear(perform: {
                getBoxSizes(proxy: proxy.size)
            })
            
        }.padding()
    }
}

