//
//  DevicePreviewer.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct DevicePreviewer: View {
    @ObservedObject var fetcher: Fetcher = Fetcher()
    @State var thermostat: Thermostat = Thermostat(id: "", name: "Heizung", setTemp: 22, currentTemp: 20, coolingDevice: false, performance: 0, luft: 65)
    
    @State var showDetail: Bool = false
    var body: some View {
        
        Button(action:{
            showDetail.toggle()
        }){
            Text("toggle")
        }.sheet(isPresented: $showDetail){
            ThermostatControl(thermostat: $thermostat)
            
        }
        
        //        {LightControl(light: $fetcher.data.rooms.first!.lights.first!)}
        //        {BlindControl(blind: $fetcher.data.rooms.first!.blinds.first!)}
//        DryerControl(dryer: $fetcher.data.dryer)
//        DishwasherControl(dishwasher: $fetcher.data.dishwasher)
//        OvenControl(oven: $fetcher.data.oven)
//        MicrowaveControl(microwave: $fetcher.data.microwave)
//        {CameraControl(camera: $fetcher.data.cameras.first!)}
//        DoorLockControl(doorLock: $fetcher.data.doorLocks.first!)
//        RobotControl(robot: $fetcher.data.robots.first!)
//        MediaDeviceControl(mediaDevice: $fetcher.data.mediaDevices.first!)
//        WeatherStationControl(weatherStation: $fetcher.data.weatherStation)
//        LightControl(light: $fetcher.data.rooms.first!.lights.first!)
        
//        ThermostatControl(thermostat: $fetcher.data.rooms.first!.thermostats.first!)
//        SensorControl(sensor: $fetcher.data.rooms.first!.sensors.first!)
//        DoorbellControl(doorbell: $fetcher.data.doorbell)
        
    }
}

struct DevicePreviewer_Previews: PreviewProvider {
    static var previews: some View {
        DevicePreviewer()
            .environmentObject(Fetcher())
    }
}
