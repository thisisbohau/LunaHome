//
//  SolarTile.swift
//  Home
//
//  Created by David Bohaumilitzky on 30.06.22.
//

import SwiftUI

struct WeatherTile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    @State var animate: Bool = false
    var indicatorWidth: CGFloat = 45
    var indicatorHeight: CGFloat = 10
    @State var icon: Image = Image(systemName: "cloud.rain.fill")
    @State var condition: Int = 1
    @State var description: String = ""
    
    func update(){
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
//                    Color.teal
                    if fetcher.data.weatherStation.rain{
                        //regen
                        RainEffect().cornerRadius(19)
                    }else if condition == 2{
                        //wolken
                        HStack{
                            Circle()
                                .frame(width: 30, height: 30)
                                .blur(radius: 10)
                        }
                    }else if condition == 3{
                        //sonne
                        VStack{
                            Spacer()
                            Image(systemName: animate ? "sun.max.fill" :  "sun.min.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.orange)
                                    .rotationEffect(Angle(degrees: animate ? 180 : 0))
                            Spacer()
                            Text("Sonne")
                                .font(.headline)
                           
                            Spacer()
                        }
                        .onAppear(perform: {
                            withAnimation(.easeInOut.speed(0.2).delay(3).repeatForever()){
                                animate.toggle()
                            }
                        })
                    }
                
                    HStack{
                        VStack(alignment: .leading, spacing: 0){
                            HStack(spacing: 0){
                                Text("\(Text(String(format: "%.1f", (fetcher.data.weatherStation.outsideTemp - 6))))°")
                                    .padding(.trailing, 3)
                                indicator
                                Text("\(Text(String(format: "%.1f", (fetcher.data.weatherStation.outsideTemp + 10))))°")
                                    .padding(.leading, 3)
                            }.font(.system(size: 8))
                                
                           
                            Text("\(Text(String(format: "%.1f", (fetcher.data.weatherStation.outsideTemp))))°")
                                .font(.largeTitle)
                                .padding(.top, 2)
                            HStack{
                                icon
                                    .symbolRenderingMode(.multicolor)
                                    .font(.callout)
                                if fetcher.data.weatherStation.rain{
                                    Text("Regen: \(String(format: "%.1f", fetcher.data.weatherStation.rainAmount))mm")
                                        .foregroundStyle(.secondary)
                                        .font(.caption)
                                }
                            }
                            Spacer()
                            
                            Text("Last Updated: \("now")")
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
