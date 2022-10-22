//
//  ThermostatControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

//MARK: Eingestellte Temperatur auf 0.5 Grad genau runden.
extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }

    func floor(nearest: Double) -> Double {
        let intDiv = Double(Int(self / nearest))
        return intDiv * nearest
    }
}

struct ThermostatControl: View {
    @Binding var thermostat: Thermostat
    @EnvironmentObject var fetcher: Fetcher
    
    @State var setTemp: Float = 22
    @State var color: Color = .white
    @State var showSheet: Bool = false
    
    @State var pressedCooling: Bool = false
    @State var pressedHeating: Bool = false
    
    func setup(){
        setTemp = thermostat.setTemp
    }
    func onChange(){
        let totalChange = 10 * setTemp/100
        let newTemp = Float(Double(15.0) + Double(totalChange))
        thermostat.setTemp = newTemp
        
        if thermostat.setTemp < 15{
            thermostat.performance = 0
        }else{
            thermostat.performance = 100
        }
        
    }
    var controlViewCoolingDevice: some View{
        VStack{
            HStack{
                Image(systemName: "thermometer.snowflake").foregroundColor(.gray).bold()
                Text("Klimaanlage").foregroundColor(.gray).bold()
                
                Spacer()
            }.padding([.top, .leading], 20)
            
            //Air Quality
            
            if thermostat.luft >= 40 && thermostat.luft <= 60{
                Button(action:{showSheet = true}){
                    HStack{
                        Image(systemName: "aqi.high").font(.title).foregroundColor(.red)
                        Text("Qualität").foregroundColor(.gray)
                        Spacer()
                    }.padding()
                }
                
            }else if thermostat.luft < 40{
                Button(action:{showSheet = true}){
                    HStack{
                        Image(systemName: "aqi.high").font(.title).foregroundColor(.green)
                        Text("Qualität").foregroundColor(.gray)
                        Spacer()
                    }.padding()
                }
            }else{
                Button(action:{showSheet = true}){
                    HStack{
                        Image(systemName: "aqi.high").font(.title).foregroundColor(.red)
                        Text("Qualität").foregroundColor(.gray)
                        Spacer()
                    }.padding()
                }
            }
            
            
            VStack{

                if thermostat.setTemp > 15{
                        HStack{
//                    Heizen
                            if thermostat.setTemp > thermostat.currentTemp{
                                Image(systemName: "thermometer.medium").font(.title).foregroundColor(.orange)
//kühlen
                            }else{
                                Image(systemName: "thermometer.snowflake").font(.title).foregroundColor(.teal)
                            }
                            
                            Text(String(format: "%.1f", Double(thermostat.setTemp).round(nearest: 0.5))).font(.title).bold().foregroundColor(.primary)
                        }.padding([.bottom], 60)
                        
                }else{
                        VStack{
                            
                            HStack{
                                Image(systemName: "water.waves").font(.title)
                                Text("AUS").font(.title).bold().foregroundColor(.primary)
                            }
//
                        }
                            .padding([.bottom], 60)
                       
//

                    }
                    
                    
                
                Spacer()
                VStack{
                    VerticalSlider(size: CGSize(width: 300, height: 120), value: $setTemp, lineColor: $color, onChange: onChange)
                        .cornerRadius(16)
                        .rotationEffect(Angle(degrees: -90))
                        .fixedSize()
                }

                HStack{
                    Button(action:{thermostat.setTemp = 18
                        pressedCooling.toggle()
                    }){
                        if pressedCooling == true{
                            Image(systemName: "snowflake")
                                .foregroundColor(.teal)
                        }else{
                            Image(systemName: "snowflake").foregroundColor(.primary)
                        }
                        
                        
                    }
                    
                    Text("")
                    Button(action:{thermostat.setTemp = 22
                        pressedHeating.toggle()
                    }){
                        if pressedHeating == true{
                            Image(systemName: "thermometer.medium").foregroundColor(.orange)
                        }else{
                            Image(systemName: "thermometer.medium").foregroundColor(.primary)
                        }
                        
                    }
                    
                }.font(.title)
                    .foregroundColor(.primary)
                    .padding([.top], 110)
                HStack{
                    Text("Aktuell")
                    //                Text(setTempDisplay.description)
                    Text("\(String(format: "%.1f", thermostat.currentTemp))°").font(.title).bold()
                    Text("  ")
                    Text("Luftfeuchtigkeit")
                    Text("\(thermostat.luft)%").font(.title).bold()
                }.foregroundColor(.primary)
                    .padding([.bottom], 30)
                    .padding([.top], 20)
                
                
                
                HStack{
                    
                    
                    Rectangle().foregroundColor(.teal)
                        .frame(width: 10)
                        .cornerRadius(12)
                    VStack{
                        HStack{
                            //                    Image(systemName: "lightbulb.fill")
                            Text(thermostat.name)
                            Spacer()
                        }.font(.largeTitle)
                            .bold()
                            .padding([.bottom], 1)
                        
                        HStack{
                            Text("Schlafzimmer")
                            Spacer()
                        }.foregroundColor(.gray)
                            .bold()
                        
                        
                        HStack{
                            
                            //                    Heizen
                            if thermostat.setTemp > thermostat.currentTemp{
                                Text("heizen")
                            }else if thermostat.setTemp < thermostat.currentTemp && thermostat.setTemp > 15{
                                Text("kühlen")
                            }else if thermostat.performance == 0{
                                Text("aus")
                            }
                            Spacer()
                        }
                        
                        
                        
                    }
                    
                }.frame(height: 100)
                    .padding()
                
                
                
                
                
                Spacer()
            }
            
            
        }

    }
    var controlView: some View{
        VStack{
            HStack{
                Image(systemName: "flame.fill").foregroundColor(.gray).bold()
                Text("Heizung").foregroundColor(.gray).bold()
                
                Spacer()
            }.padding([.top, .leading], 20)
            
            //Air Quality
            
            if thermostat.luft >= 40 && thermostat.luft <= 60{
                Button(action:{showSheet = true}){
                    HStack{
                        Image(systemName: "aqi.high").font(.title).foregroundColor(.red)
                        Text("Qualität").foregroundColor(.gray)
                        Spacer()
                    }.padding()
                }
                
            }else if thermostat.luft < 40{
                Button(action:{showSheet = true}){
                    HStack{
                        Image(systemName: "aqi.high").font(.title).foregroundColor(.green)
                        Text("Qualität").foregroundColor(.gray)
                        Spacer()
                    }.padding()
                }
            }else{
                Button(action:{showSheet = true}){
                    HStack{
                        Image(systemName: "aqi.high").font(.title).foregroundColor(.red)
                        Text("Qualität").foregroundColor(.gray)
                        Spacer()
                    }.padding()
                }
            }
            
            
            VStack{

                if thermostat.setTemp > 15{
                        HStack{
                            Image(systemName: "flame.fill").font(.title).foregroundColor(.orange)
                            Text(String(format: "%.1f", Double(thermostat.setTemp).round(nearest: 0.5))).font(.title).bold().foregroundColor(.primary)
                        }.padding([.bottom], 60)
                        
                }else{
                        VStack{
                            
                            HStack{
                                Image(systemName: "water.waves").font(.title)
                                Text("AUS").font(.title).bold().foregroundColor(.primary)
                            }
//
                        }
                            .padding([.bottom], 60)
                       
//

                    }
                    
                    
                
                Spacer()
                VStack{
                    VerticalSlider(size: CGSize(width: 300, height: 120), value: $setTemp, lineColor: $color, onChange: onChange)
                        .cornerRadius(16)
                        .rotationEffect(Angle(degrees: -90))
                        .fixedSize()
                }
                Spacer()
                HStack{
                    Text("Aktuell")
                    //                Text(setTempDisplay.description)
                    Text("\(String(format: "%.1f", thermostat.currentTemp))°").font(.title).bold()
                    Text("  ")
                    Text("Luftfeuchtigkeit")
                    Text("\(thermostat.luft)%").font(.title).bold()
                }.foregroundColor(.primary)
                    .padding([.bottom], 30)
                    .padding([.top], 70)
                
                HStack{
                    
                    
                    Rectangle().foregroundColor(.teal)
                        .frame(width: 10)
                        .cornerRadius(12)
                    VStack{
                        HStack{
                            //                    Image(systemName: "lightbulb.fill")
                            Text(thermostat.name)
                            Spacer()
                        }.font(.largeTitle)
                            .bold()
                            .padding([.bottom], 1)
                        
                        HStack{
                            Text("Schlafzimmer")
                            Spacer()
                        }.foregroundColor(.gray)
                            .bold()
                        
                        
                        HStack{
                            
                            if thermostat.setTemp >= 15{
                                Text("heizen")
                                Spacer()
                            }else{
                                Text("Frostschutz")
                                Spacer()
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }.frame(height: 100)
                    .padding()
                
                
                
                
                
                Spacer()
            }
            
            
        }
    }
    var body: some View {
        VStack{
            
       
//        Heizung Control
        if thermostat.coolingDevice == false{
            ZStack{
                VStack{
                    if thermostat.setTemp > 15 && thermostat.setTemp <= 19{
                        Color.green
                    }else if thermostat.setTemp >= 19 && thermostat.setTemp < 22{
                        Color.yellow
                    }else if thermostat.setTemp >= 22 && thermostat.setTemp < 24{
                        Color.orange
                    }else if thermostat.setTemp >= 24{
                        Color.red
                    }else{
                        Color.black
                    }
                }
                .ignoresSafeArea()
                .overlay(.thickMaterial)
                
                controlView
            }
//            Cooling Control
        }else{
            ZStack{
                VStack{
//                    Heizen
                    if thermostat.setTemp > thermostat.currentTemp{
                        Color.orange
//kühlen
                    }else{
                        Color.teal
                    }
                }
                .ignoresSafeArea()
                .overlay(.thickMaterial)
                
                controlViewCoolingDevice
            }
            
        }
        
        
       
        }
        
            
            
        .sheet(isPresented: $showSheet){
            AirQuality()
        }
        .onAppear(perform: {
            setup()
        })
        
       
        
       
        
    }
        
}
