//
//  FoodplanerTile.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 02.10.22.
//

import SwiftUI

struct FoodplanerTile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    
    var body: some View {
        MediumTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
            .overlay(
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "timer")
                        Text("25")
                        Text("|")
                        Text("einfach")
                        Spacer()
                    }
                    .font(.caption)
                    Text("Feta-Nudeln")
                        .bold()
                    
                    
                    Spacer()
                    
                    Button(action: {
                        fetcher.data.oven.recipe = "Feta-Nudeln"
                        fetcher.data.oven.timer = 1
                        fetcher.data.oven.setTemp = 220
                        fetcher.data.oven.preHeat = true
                        fetcher.data.oven.mode = "Ober- Unterhitze"
                        fetcher.data.oven.state = true
                        fetcher.timerStartedAt = Date()
                    }){
                        HStack{
                            Text("Jetzt kochen")
                                .foregroundColor(.white)
                                .font(.caption.bold())
                                .padding([.leading, .trailing],10)
                                .padding([.top, .bottom],7)
                                .background(Color.accentColor)
                                .cornerRadius(30)
                            Spacer()
                        }
                    }
                   
                }.foregroundColor(.white)
                    .padding()
                    .background(
                        Image("fetaNudeln")
                            .resizable()
                            .overlay(
                                Color.black.opacity(0.3)
                            )
                            .cornerRadius(DeviceItemCalculator().cornerRadius)
                    )
            )
        
            .padding(.bottom, DeviceItemCalculator().spacer)
    }
}

