//
//  Overview.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 26.08.22.
//

import SwiftUI

struct GeofenceItem: Identifiable{
    var id: Int
    var name: String
    var isCurrent: Bool?
}

struct OverviewMain: View {
  
    @Environment(\.redactionReasons) var redactionReasons
    @EnvironmentObject var data: Fetcher

    @State var geofenceItems: [GeofenceItem] = [GeofenceItem]()
    @State var animateGradient: Bool = false
    @State var animate: Bool = false
    @State var animateUpdate: Bool = false
    @State var room: Room = Fetcher().data.rooms.first!
    
        
    func update(){
        geofenceItems.append(GeofenceItem(id: 1, name: "carina", isCurrent:  true))
        geofenceItems.append(GeofenceItem(id: 2, name: "david"))
        
    }
  
    
    var geofence: some View{
        ZStack{
            ForEach(geofenceItems){item in
                Image(item.name.lowercased())
                    .resizable()
                    .frame(width: item.isCurrent ?? false ? 45 : 35, height: item.isCurrent ?? false ? 45 : 35)
                    .foregroundColor(Color("fill"))
                    .background(Circle().foregroundColor(Color("fill")))
                    .foregroundStyle(.ultraThickMaterial)
                    .onCondition(item.isCurrent ?? false, transform: {view in
                        view
                            .overlay(Circle().trim(from: 0, to: animateUpdate ? 0.2 : 1).stroke(style: StrokeStyle(lineWidth: 1.5)).foregroundColor( Color("fill")).rotationEffect(Angle(degrees: animateUpdate ? -90 :  90)))
                        
                    })
                    .onCondition(!(item.isCurrent ?? false), transform: {view in
                        view
                            .overlay(Circle().stroke(style: StrokeStyle(lineWidth: 1)).foregroundColor(Color("fill")))
                    })
                    .shadow(radius: 2)
                    .offset(x: CGFloat(Int(item.id)) * (item.isCurrent ?? false ? -30 : -25))
                    .zIndex(Double(item.id * -1))
            }
        }
    }
    
    var background: some View{
        ZStack{
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        }
    }

    
    var topBar: some View{
        HStack{
            Text("Hallo David")
                .font(.largeTitle)
                .bold()
            Spacer()
            geofence
                .padding(2)
        }
    }
    
    var body: some View {
        GeometryReader{proxy in
            VStack(spacing: 0){
                ScrollView(showsIndicators: false){
                    topBar
                    
                    HStack(spacing: 0){
                        VStack(spacing: 0){

//                            SmallTemplate(proxy: proxy.size, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
//                                .overlay(
//                                    HStack{
//                                        Circle()
//                                            .stroke(style: StrokeStyle(lineWidth: 5))
//                                            .padding(13)
//                                            .foregroundColor(.green)
//                                            .overlay(Image(systemName: "bolt.fill")
//
//                                                .foregroundStyle(.secondary)
//                                                .foregroundColor(.primary)
//                                            )
//                                        VStack(alignment: .leading){
//                                            Text("Battery")
//                                                .font(.headline)
//                                            Text("2kW - now")
//                                                .font(.caption)
//                                                .foregroundStyle(.secondary)
//                                        }
//
//                                        Spacer()
//                                    }
//                                )
//                                .padding(.bottom, DeviceItemCalculator().spacer)
                            LightShadeTile(proxy: proxy.size)
                            NukiTile(proxy: proxy.size)
                            DoorbellTile(proxy: proxy.size)

                            Spacer()
                        }
                        .padding(.trailing, DeviceItemCalculator().spacer)

                        VStack(spacing: 0){
                            WeatherTile(proxy: proxy.size, animate: false)
                            
//                            SmallTemplate(proxy: proxy.size, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
//                                .padding(.bottom, DeviceItemCalculator().spacer)

                            Spacer()
                        }
                    }
                   
                    Spacer()
                }
                
                
            }
        }
        .padding()
        .onAppear(perform: {
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                withAnimation(.easeInOut(duration: 3).repeatForever()){
                    animate.toggle()
                }
            })
        })
        .background(background.ignoresSafeArea())
        .onAppear(perform: {
            update()
            animateUpdate = true
            withAnimation(.linear(duration: 0.5)){
                animateUpdate.toggle()
            }
        })
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        OverviewMain()
    }
}
