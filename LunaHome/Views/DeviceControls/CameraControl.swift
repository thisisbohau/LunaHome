//
//  CameraControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct CameraControl: View {
    @Binding var camera: Camera
    
    var body: some View {
//        Text(String(describing: camera))
        ZStack{
            VStack{
                Rectangle()
                    .cornerRadius(15)
                    .padding()
                    .foregroundStyle(.gray)
                
                Spacer()
                    
            }
            VStack{
                HStack{
                    Circle()
                        .foregroundColor(Color.blue)
                        .frame(width: 40)
                        .padding()
                    Text("Kamera Einfahrt")
                        .bold()
                    Spacer()
                }
                
                Spacer()
            }.padding()
            
            
        }.ignoresSafeArea()
        
    }
}
