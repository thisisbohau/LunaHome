//
//  Washer Tile.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 10.10.22.
//

import SwiftUI

struct Washer_Tile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    @State var show: Bool = false
    @State var animate: Bool = false
    
    var animation: some View{
        ZStack{
//            VStack{
//                Rectangle().foregroundStyle(.tertiary)
//                    .frame(width: 150, height: 190)
//                    .cornerRadius(19)
//            }
            VStack{
                Circle()
                    .frame(width: 50)
                    .foregroundColor(.secondary)
            }
            VStack{
                LinearGradient(colors: [fetcher.data.washer.state ? .blue : .teal, .teal], startPoint: .top, endPoint: .bottom)
                    .frame(width: 40, height: 40)
                    
                    .clipShape(Circle())
                    .rotationEffect(Angle(degrees: animate ? 360 : 0))
            }
//            .offset(y:20)
            
//            HStack{
//                Circle()
//                    .frame(width: 15)
//                    .foregroundColor(.secondary)
//            }.offset(x:-55, y:-75)
//
//            HStack{
//                Circle()
//                    .frame(width: 15)
//                    .foregroundColor(.secondary)
//            }.offset(x:-35, y:-75)
//            HStack{
//                Rectangle()
//                    .frame(width: 35, height: 15)
//                    .cornerRadius(12)
//                    .foregroundColor(.secondary)
//            }.offset(x:45, y:-75)
            
        }
    }
    var body: some View {
        if fetcher.data.washer.state{
            MediumTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
                .overlay(
                    Button(action: {show.toggle()}){
                        HStack{
                            VStack(alignment: .leading){
                                Text("Waschmaschine")
                                    .font(.body)
                                    .bold()
                                Text("Läuft \(Text(fetcher.washerStartedAt, style: .timer))")
                                    .foregroundColor(.orange
                                    )
                                    .font(.caption)
                                
                               
                                Spacer()
                                HStack{
                                    Spacer()
                                    Text(fetcher.data.washer.programm)
                                        .bold()
                                        .font(.caption)
//                                        .padding(.trailing, 10)
                                    Spacer()
                                    animation
                                    Spacer()
                                }
                                
                                Spacer()

                            }
                            Spacer()
                        }
                        
                        .padding()
                    }.foregroundColor(.primary)
                )
                .padding(.bottom, DeviceItemCalculator().spacer)
                .sheet(isPresented: $show){
                    WasherControl()
                }
                .onAppear(perform: {
                    withAnimation(.linear(duration: 1).repeatForever()){
                        animate.toggle()
                    }
                })
        }else{
            SmallTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
                .overlay(
                    Button(action: {show.toggle()}){
                        HStack{
                            VStack(alignment: .leading){
                                Text("Waschmaschine")
                                    .font(.body)
                                    .bold()
                                Text("Zum Starten Tippen")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            Spacer()
                            //                    Image(systemName: "washer")
                            //                        .foregroundColor(.secondary)
                            //                        .font(.headline)
                        }
                        
                        .padding()
                    }.foregroundColor(.primary)
                )
                .padding(.bottom, DeviceItemCalculator().spacer)
                .sheet(isPresented: $show){
                    WasherControl()
                }
        }
   
    }
}

//struct Washer_Tile_Previews: PreviewProvider {
//    static var previews: some View {
//        Washer_Tile()
//    }
//}
