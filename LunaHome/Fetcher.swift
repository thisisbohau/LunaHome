//
//  Fetcher.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 07.07.22.
//

import Foundation


extension Encodable {
    var convertToString: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

struct Home: Codable{
    var rooms: [Room]
    var dryer: Dryer
    var oven: Oven
    var microwave: Microwave
    var dishwasher: Dishwasher
    var washer: Washer
    
    var doorLocks: [DoorLock]
    var weatherStation: WeatherStation
    var robots: [Robot]
    var cameras: [Camera]
    var mediaDevices: [MediaDevice]
    var predictions: [Prediction]
    var recommendations: [LunaEntry]
}

@MainActor
class Fetcher: ObservableObject{
    @Published var data: Home = Home(rooms: [Room(id: "test", name: "Test", floor: 0, lights: [Light(id: "testLampLamp", state: true, hue: 120, saturation: 255, brightness: 80, type: "Stripe", name: "Ambient")], blinds: [Blind(id: "testBlind", name: "Blind", position: 78, closed: false)], thermostats: [Thermostat(id: "testThermo", name: "Heizung Schlafzimmer", setTemp: 22.5, currentTemp: 20, coolingDevice: false, performance: 80, luft: 65)], sensors: [Sensor(id: "testSensor", name: "Türsensor", triggered: true, type: 2, triggeredAt: "123456")])], dryer: Dryer(state: false, runTime: 0, programm: "", health: [String]()), oven:  Oven(state: false, preHeat: false, setTemp: 0, timer: 0, mode: "", recipe: ""), microwave: Microwave(state: false, programm: "", watt: 0, timer: 0), dishwasher: Dishwasher(state: false, runTime: 0, programm: "", health: [String]()), washer: Washer(state: false, runTime: 0, programm: "", health: [String](), beschmutzung: "", temperatur: "", schleudern: ""), doorLocks: [DoorLock(id: "testLock", name: "Haustüre", battery: 98, doorAjar: false, doorOpen: false, doorError: false)], weatherStation: WeatherStation(outsideTemp: 18.6, windSpeed: 5, humidity: 35, co2: 600, weatherWarning: [String](), rainAmount: 4, rain: true), robots: [Robot(id: "testRobot", name: "Bernd", type: 1, state: true, error: "", timeRemaining: 16, currentJob: ["Wohnzimmer, Küche", "Bad"])], cameras: [Camera(id: "testCam", name: "Haustüre", feedName: "DoorbellFeed", detectedObjects: ["David", "Paket"])], mediaDevices:  [MediaDevice(id: "testMedia", name: "HomePod Küche", state: true, volume: 70, content: "Song: Daydreamer")], predictions: [Prediction(id: "1", title: "Haustüre", predictable: true, data: [DataPoint(id: "1", value: 10, title: "di"), DataPoint(id: "2", value: 30, title: "Mo")], description: "h", averageUnit: "h", diagramType: 0)], recommendations: [LunaEntry(id: "", title: "", message: "", priority: 0, image: "", color: "")])
    private let store = Store()
    @Published var startedAt: Date = Date()
    @Published var timerStartedAt: Date = Date()
    
    @Published var washerStartedAt: Date = Date()
    
    @Published var showSetup: Bool = false
    
    func logTemplate(){
        let jjson = data.convertToString ?? ""
        print("\n\nCurrent Home Template: \n\n\n\(jjson)\n\n\nEnd")
    }
    func load() async{
        guard let response = await store.load() else{
            print("Unable to fetch Home data")
            return
        }
        DispatchQueue.main.async { [self] in
            data = response
            startedAt = Date()
            timerStartedAt = Date()
            washerStartedAt = Calendar.current.date(byAdding: .minute, value: -29, to: Date()) ?? Date()
            
            if SettingsData().getUserName() == ""{
                showSetup = true
            }
        }
        
    }
}

extension Fetcher{
    private actor Store {
        fileprivate static var dataURL: URL {
            get throws {
                let bundle = Bundle.main
                guard let path = bundle.path(forResource: "Home", ofType: "json") else {
                    throw CocoaError(.fileReadNoSuchFile)
                }
                return URL(fileURLWithPath: path)
            }
        }
        
        /// Fetches  Home data from file.
        /// - Returns: If successful the complete Home structure
        func load() -> Home? {
            loadData(from: .main)
        }
        
        func loadData(from bundle: Bundle) -> Home?{
            do{
                let data = try Data(contentsOf: Store.dataURL, options: .mappedIfSafe)
                
                return try JSONDecoder().decode(Home.self, from: data)
            }catch CocoaError.fileReadNoSuchFile{
                return nil
            }catch{
                print("error while decoding home")
                return nil
//                fatalError("Fatal Error while fetching data")
            }
        }
    }
}
