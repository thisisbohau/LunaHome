//
//  DeviceTester.swift
//  LunaHome
//
//  Created by Carina Schmidinger on 30.09.22.
//

import SwiftUI

struct DeviceTester: View {
    var proxy: CGSize
    @State var show: Bool = false
    @EnvironmentObject var fetcher: Fetcher
    
    var body: some View {
        MediumTemplate(proxy: proxy, type: .overlay, device: "")
            .overlay(
                Button(action: {show.toggle()}){
                    VStack{
                        Image(systemName: "testtube.2")
                            .font(.largeTitle)
                            .foregroundColor(.teal)
                        Text("TEST")
                            .bold()
                            .padding(.top)
                            .foregroundStyle(.primary)
                    }
                }
            )
            .padding(.bottom, DeviceItemCalculator().spacer)
            .sheet(isPresented: $show){
                WasherControl()
            }
    }
}

