//
//  OvenTile.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 30.09.22.
//

import SwiftUI

struct OvenTile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    @State var timerActive: Bool = true
    @State var showDetail: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func getTimer() -> Text{
        let endDate = Calendar.current.date(byAdding: .minute, value: fetcher.data.oven.timer, to: fetcher.timerStartedAt) ?? Date()
        
        return Text("Noch \(endDate, style: .timer)min")
    }
    
    func checkTimer(){
        let endDate = Calendar.current.date(byAdding: .minute, value: fetcher.data.oven.timer, to: fetcher.timerStartedAt) ?? Date()
        timerActive = endDate < Date() ? false : true
    }
 
    var body: some View {
        Button(action: {showDetail.toggle()}){
            if fetcher.data.oven.state{
                MediumTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
                    .overlay(
                        VStack(alignment: .leading){
                            HStack(alignment: .top){
                                VStack(alignment: .leading){
                                    Text("Backofen")
                                        .font(.body)
                                        .bold()
                                        .foregroundColor(.primary)
                                    Text(fetcher.data.oven.mode)
                                        .foregroundColor(.secondary)
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: "water.waves")
                                    .foregroundColor(.orange)
                                    .font(.headline)
                            }
                            Spacer()
                            
                            if timerActive{
                                Text("Eingestellt auf")
                                    .foregroundStyle(.primary)
                                    .font(.caption)
                                Text("\(Int(fetcher.data.oven.setTemp))°C")
                                    .font(.title3.bold())
                                
                                HStack{
                                    Image(systemName: "timer")
                                        .foregroundColor(.orange)
                                    getTimer()
                                    
                                }.font(.caption)
                            }else{
                                VStack{
                                    Text("\(fetcher.data.oven.timer) Minuten Timer")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    HStack{
                                        Spacer()
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.green)
                                        Text("Fertig")
                                        Spacer()
                                    }.bold()
                                }
                            }
                            Spacer()
                        }
                        
                        
                            .padding()
                    )
                    .foregroundColor(.primary)
                    .onReceive(timer.self, perform: {_ in checkTimer()})
                    .padding(.bottom, DeviceItemCalculator().spacer)
            }else{
                SmallTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
                    .overlay(
                        HStack{
                            VStack(alignment: .leading){
                                Text("Backofen")
                                    .font(.body)
                                    .bold()
                                Text("Aus")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            Spacer()
                            Image(systemName: "water.waves")
                                .foregroundColor(.secondary)
                                .font(.headline)
                        }
                        
                            .padding()
                    )
                    .foregroundColor(.primary)
                    .padding(.bottom, DeviceItemCalculator().spacer)
            }
        }
        .sheet(isPresented: $showDetail){
            OvenControl()
        }
    }
}
//
//struct OvenTile_Previews: PreviewProvider {
//    static var previews: some View {
//        OvenTile()
//    }
//}
