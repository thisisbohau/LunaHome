//
//  SolarTile.swift
//  Home
//
//  Created by David Bohaumilitzky on 30.06.22.
//

import SwiftUI

struct SolarTile: View {
    var proxy: CGSize
    @State var animate: Bool = false
    
    var body: some View {
        MediumTemplate(proxy: proxy, type: .overlay, device: "")
            .overlay(
                VStack{
                    Spacer()
                    Image(systemName: animate ? "sun.max.fill" :  "sun.min.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                            .rotationEffect(Angle(degrees: animate ? 180 : 0))
                    Spacer()
                    Text("Solar")
                        .font(.headline)
                    Text("3.8kW - now")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            )
            .padding(.bottom, DeviceItemCalculator().spacer)
            .onAppear(perform: {
                withAnimation(.easeInOut.speed(0.2).delay(3).repeatForever()){
                    animate.toggle()
                }
            })
    }
}
