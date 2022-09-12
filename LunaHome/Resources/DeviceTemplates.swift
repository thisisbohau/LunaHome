//
//  DeviceTemplates.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import Foundation

struct Prediction: Identifiable, Codable{
    var id: String
    var title: String
    var predictable: Bool
    var data: [DataPoint]
    var description: String
    var averageUnit: String
    var diagramType: Int
}

struct DataPoint: Identifiable, Codable{
    var id: String
    var value: Float
    var title: String
}

struct Room: Identifiable, Codable{
    var id: String
    var name: String
    var floor: Int
    var lights: [LightGroup]
    var blinds: [BlindGroup]
    var thermostats: [Thermostat]
    var sensors: [Sensor]
}

struct LightGroup: Identifiable, Codable{
    var id: String
    var single: Bool
    var lights: [Light]
}

struct BlindGroup: Identifiable, Codable{
    var id: String
    var single: Bool
    var blinds: [Blind]
}

struct Dishwasher: Codable{
    var state: Bool
    var runTime: Int
    var programm: String
    var health: [String]
}

struct Washer: Codable{
    var state: Bool
    var runTime: Int
    var programm: String
    var health: [String]
}

struct Dryer: Codable{
    var state: Bool
    var runTime: Int
    var programm: String
    var health: [String]
}

struct Oven: Codable{
    var state: Bool
    var preHeat: Bool
    var setTemp: Float
    var timer: Int
    var mode: String
    var recipe: String
}

struct Microwave: Codable{
    var state: Bool
    var programm: String
    var watt: Float
    var timer: Int
}

struct Light: Identifiable, Codable{
    var id: String
    var state: Bool
    var hue: Float
    var saturation: Float
    var brightness: Int
    var type: String
    var name: String
}

struct Blind: Identifiable, Codable{
    var id: String
    var name: String
    var position: Int
    var closed: Bool
}

struct Thermostat: Identifiable, Codable{
    var id: String
    var name: String
    var setTemp: Float
    var currentTemp: Float
    var coolingDevice: Bool
    var performance: Int
}

/// type:
/// 1 = Fenstersensor
/// 2 = Türsensor
/// 3 = Rauchmelder
/// 4 = Wassersensor
/// 5 = Andere
struct Sensor: Identifiable, Codable{
    var id: String
    var name: String
    var triggered: Bool
    var type: Int
    var triggeredAt: String
}

struct DoorLock: Identifiable, Codable{
    var id: String
    var name: String
    var battery: Int
    var doorAjar: Bool
    var doorOpen: Bool
    var doorError: Bool
}

struct WeatherStation: Codable{
    var outsideTemp: Float
    var windSpeed: Float
    var humidity: Float
    var co2: Float
    var weatherWarning: [String]
    var rainAmount: Float
    var rain: Bool
}

struct Robot: Identifiable, Codable{
    var id: String
    var name: String
    var type: Int
    var state: Bool
    var error: String
    var timeRemaining: Int
    var currentJob: [String]
}

struct Camera: Identifiable, Codable{
    var id: String
    var name: String
    var feedName: String
    var detectedObjects: [String]
}

struct Doorbell: Codable{
    var ring: Bool
    var lastPush: String
}

struct MediaDevice: Identifiable, Codable{
    var id: String
    var name: String
    var state: Bool
    var volume: Int
    var content: String
}
