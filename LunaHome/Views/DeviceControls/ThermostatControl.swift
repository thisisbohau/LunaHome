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
    
    func setup(){
        setTemp = thermostat.setTemp
    }
    func onChange(){
        let totalChange = 10 * setTemp/100
        let newTemp = Float(Double(15.0) + Double(totalChange))
        thermostat.setTemp = newTemp
        
        if setTemp < 19{
//            color = .green
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
        
        controlView
            .onCondition(setTemp > 15, transform: {view in view
                    .background(Color.yellow.ignoresSafeArea().overlay(.thickMaterial))
            })
        
            
            .sheet(isPresented: $showSheet){
                AirQuality()
            }
            .onAppear(perform: {
                setup()
            })
        
        
       
        
       
        
    }
    
}
