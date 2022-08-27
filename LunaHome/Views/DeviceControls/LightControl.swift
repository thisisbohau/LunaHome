//
//  LightControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct LightControl: View {
    @Binding var light: Light
    
    var body: some View {
        VStack{
            Text(light.name)
                .font(.largeTitle.bold())
                .padding()
                .foregroundColor(.blue)
        }
    }
}

