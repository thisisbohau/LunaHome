//
//  WeatherTile.swift
//  Home
//
//  Created by David Bohaumilitzky on 30.06.22.
//

import SwiftUI

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}

struct WeatherTile: View {
    var proxy: CGSize
    
    var indicatorWidth: CGFloat = 45
    var indicatorHeight: CGFloat = 10
    @State var icon: Image = Image(systemName: "checkmark")
    @State var condition: Int = 0
    @State var description: String = ""
    
    func update(){
        Task{
//            icon = await WeatherKit().getIcon(weather: Weather(currentTemp: 0, low: 0, hight: 0, humidity: 0, condition: 3, rainCurrent: 0, rainToday: 0, lastUpdate: "", rain: true, heavyRain: true, weatherAdaption: Switch(id: 0, state: false, name: "", description: "")))
//            let conditions = await WeatherKit().getCondition(weather: Weather(currentTemp: 0, low: 0, hight: 0, humidity: 0, condition: 2, rainCurrent: 0, rainToday: 0, lastUpdate: "", rain: true, heavyRain: true, weatherAdaption: Switch(id: 0, state: false, name: "", description: "")))
                                                             
//            condition = conditions.0
//            description = conditions.1
        }
    }
    
    var indicator: some View{
        ZStack{
            HStack{
                LinearGradient(colors: [Color("tadoCold"),
                                        Color("tadoCool"), Color("tadoMidLow"), Color("tadoNormal"), Color("tadoMidHigh"), Color("tadoMax")], startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
            }.frame(width: indicatorWidth, height: indicatorHeight).cornerRadius(30)
            HStack{
                Circle()
                    .frame(width: indicatorHeight, height: indicatorHeight)

                Spacer()
            }
//            .offset(x: CGFloat(40*(data.status.weather.currentTemp/data.status.weather.hight)))
            .offset(x: CGFloat(indicatorWidth*(15/25)))
        }.frame(width: indicatorWidth).cornerRadius(30)
        
    }
    
    var body: some View {
        MediumTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
            .overlay(
                ZStack{
                    if condition == 3 || condition == 5{
//                        RainEffect().cornerRadius(19)
                    }else if condition == 2{
                        HStack{
                            Circle()
                                .frame(width: 30, height: 30)
                                .blur(radius: 10)
                        }
                    }else if condition == 4{
                        
                    }else if condition == 1{
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("tadoNormal"))
                                    .blur(radius: 15)
                                    .overlay(
                                        Circle()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color("tadoMax"))
                                        .blur(radius: 10)
                                    )
                                Spacer()
                            }
                            .padding(.trailing, 30)
                        }
                    }
                   

                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0){
                            HStack(spacing: 0){
                                Text("15°")
                                    .padding(.trailing, 3)
                                indicator
                                Text("28°")
                                    .padding(.leading, 3)
                            }.font(.system(size: 8))
                                
                           
                            Text("21°")
                                .font(.largeTitle)
                                .padding(.top, 2)
                            icon
                                .symbolRenderingMode(.multicolor)
                                .font(.callout)
                            Spacer()
                            
                            Text("Last Updated \("now")")
                                .font(.system(size: 8))
                                .foregroundStyle(.secondary)
                                .offset(y: 3)
                        }
                        Spacer()
                    }.padding()
                
                    
                    
                    
                    
                }
            )
            
            .padding(.bottom, DeviceItemCalculator().spacer)
            .onAppear(perform: update)
    }
}
