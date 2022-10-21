//
//  ThermostatControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct ThermostatControl: View {
    @Binding var thermostat: Thermostat
    @EnvironmentObject var fetcher: Fetcher
    
    @State var setTemp: Float = 22
    @State var aktuelleTemp: Float = 1
    
    @State var color: Color = .orange
    
    func onChange(){
        aktuelleTemp = setTemp * 0.3
        thermostat.setTemp = setTemp
        
    }
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "flame.fill").foregroundColor(.gray).bold()
                Text("Heizung").foregroundColor(.gray).bold()

                Spacer()
            }.padding(20)
            .padding([.bottom], 40)
            
            
            
            HStack{
                Image(systemName: "flame.fill").font(.title).foregroundColor(.orange)
                Text(String(format: "%.1f", setTemp)).font(.title).bold().foregroundColor(.gray)
            }
            Spacer()
            VStack{
                VerticalSlider(size: CGSize(width: 300, height: 110), value: $setTemp, lineColor: $color, onChange: onChange )
                    .cornerRadius(14)
                    .rotationEffect(Angle(degrees: -90))
                    .fixedSize()
            }
Spacer()
            HStack{
                Text("Aktuell")
                Text("\(String(format: "%.1f", aktuelleTemp))°").font(.title).bold()
                Text("  ")
                Text("Luftfeuchtigkeit")
                Text("\(thermostat.luft)%").font(.title).bold()
            }.foregroundColor(.gray)
            
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
                        
                    if fetcher.data.washer.state == true{
                        Text("an")
                        Spacer()
                    }else{
                        Text("aus")
                        Spacer()
                    }
                    
                }
                
                
                
            }
                
            }.frame(height: 100)
                .padding()
            
            
            if thermostat.luft >= 40 && thermostat.luft <= 60{
                VStack{
                    HStack{
                        ZStack{
                            Circle().foregroundColor(.teal).frame(width: 60)
                            Image(systemName: "aqi.high").font(.title).foregroundColor(.white)
                        }.padding([.trailing])
                        VStack(alignment: .leading){
                            Text("Gut").font(.title).bold()
                            Text("Luftqualität").foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    
                }.padding()
            }else if thermostat.luft >= 60{
                VStack{
                    HStack{
                        ZStack{
                            Circle().foregroundColor(.teal).frame(width: 60)
                            Image(systemName: "aqi.high").font(.title).foregroundColor(.white)
                        }.padding([.trailing])
                        VStack(alignment: .leading){
                            Text("Fenster öffnen").font(.title).bold()
                            Text("Luftqualität").foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {}){
                            Image(systemName: "info.circle.fill").font(.title)
                        }.foregroundColor(.primary)
                        

                    }
                    
                }.padding()
            }else{
                VStack{
                    HStack{
                        ZStack{
                            Circle().foregroundColor(.teal).frame(width: 60)
                            Image(systemName: "aqi.high").font(.title).foregroundColor(.white)
                        }.padding([.trailing])
                        VStack(alignment: .leading){
                            Text("Luftqualität").font(.title).bold()
                            Text("Bitte Fenster schließen.").foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    
                }.padding()
            }
            
            
//            Spacer()
        }
 
        
    }
    
}

