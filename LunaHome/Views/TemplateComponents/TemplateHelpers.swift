//
//  TemplateHelpers.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 26.08.22.
//

import Foundation
import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `onCondition`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

enum DeviceItemSize{
    case small
    case medium
    case large
}

struct DeviceListEntry: Identifiable{
    var id: String
    var device: Any
    var type: DeviceType
    var size: DeviceItemSize?
}

class DeviceItemCalculator{
    let spacer: CGFloat = 10
    let cornerRadius: CGFloat = 18
    
    func getOddItems(items: [DeviceListEntry]) -> [DeviceListEntry]{
        var itemsAtEvenIndices = [DeviceListEntry]()
        var index = 0
        for item in items {
          if index % 2 != 0 {
            itemsAtEvenIndices.append(item)
          }
          index += 1
        }
        return itemsAtEvenIndices
    }
    func getEvenItems(items: [DeviceListEntry]) -> [DeviceListEntry]{
        var itemsAtEvenIndices = [DeviceListEntry]()
        var index = 0
        for item in items {
          if index % 2 == 0 {
            itemsAtEvenIndices.append(item)
          }
          index += 1
        }
        return itemsAtEvenIndices
    }
    func getDeviceLargeSize(proxy: CGSize) -> CGSize{
        //half the screen width on iPhone, 60% of the width equals the height
        let availableWidth = proxy.width
        var itemWidth: CGFloat = 10
        
        if true{
            itemWidth = (availableWidth-5)/2
        }else{
            itemWidth = (availableWidth-30)/5
        }
        
        let itemHeight = itemWidth*0.79
        
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    func getDeviceXLargeSize(proxy: CGSize) -> CGSize{
        //half the screen width on iPhone, 60% of the width equals the height
        let availableWidth = proxy.width
        var itemWidth: CGFloat = 10
        
        if true{
            itemWidth = (availableWidth-5)/2
        }else{
            itemWidth = (availableWidth-30)/5
        }
        
        let itemHeight = itemWidth*0.79 + (itemWidth/2)*0.79 + 5
        
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    func getDeviceSmallSize(proxy: CGSize) -> CGSize{
        //half the screen width on iPhone, 60% of the width equals the height
        let availableWidth = proxy.width
        var itemWidth: CGFloat = 10
        
        if true{
            itemWidth = (availableWidth-5)/2
        }else{
            itemWidth = (availableWidth-30)/5
        }
        
        let itemHeight = (itemWidth/2)*0.79-5
        
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
}

struct DeviceIcon: View {
    var type: DeviceType
    @State var device: Any
    
    func getLight(device: Any) -> Light{
        return device as! Light
    }
    func getLightIcon(device: Any) -> String{
        if (device as! Light).type == "ColorBulb"{
            return "lightbulb.fill"
        }else if (device as! Light).type == "ColorStrip"{
            return "light.panel"
        }else{
            return "light.recessed.fill"
        }
    }
    var body: some View {
        HStack{
            VStack{
                switch type{
                case .light:
                    if getLight(device: device).state{
                        Image(systemName: getLightIcon(device: device))
                            .foregroundColor(.white)
                    }else{
                        Image(systemName: getLightIcon(device: device))
                            .foregroundStyle(.secondary)
                    }
                    
                case .blind:
                    if (device as! Blind).position > 5{
                        Image(systemName: "blinds.horizontal.open")
                            .foregroundColor(.white)
                    }else{
                        Image(systemName: "blinds.horizontal.closed")
                            .foregroundStyle(.secondary)
                    }
                   
                case .motion:
                    Image(systemName: "light.recessed.fill")
                case .window:
                    Image(systemName: "light.recessed.fill")
                   Spacer()
                default:
                    Image(systemName: "light.recessed.fill")
                }
            }
            
    
            
        }
       
//        .background(.red)
    }
}
