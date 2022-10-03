//
//  WasherControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct WasherControl: View {
    @Binding var washer: Washer
    @State var showProgramm: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "washer.fill").foregroundColor(.gray).bold()
                Text("Waschmaschine").foregroundColor(.gray).bold()

                Spacer()
            }.padding(20)
            .padding([.bottom], 40)
            
            
            
            
            ZStack{
                VStack{
                    Rectangle().foregroundStyle(.tertiary)
                        .frame(width: 150, height: 190)
                        .cornerRadius(19)
                }
                VStack{
                    Circle()
                        .frame(width: 100)
                        .foregroundColor(.teal)
                }.offset(y:20)
                
                HStack{
                    Circle()
                        .frame(width: 15)
                        .foregroundColor(.secondary)
                }.offset(x:-55, y:-75)
                
                HStack{
                    Circle()
                        .frame(width: 15)
                        .foregroundColor(.secondary)
                }.offset(x:-35, y:-75)
                HStack{
                    Rectangle()
                        .frame(width: 35, height: 15)
                        .cornerRadius(12)
                        .foregroundColor(.secondary)
                }.offset(x:45, y:-75)
                
            }.padding([.bottom])
            
//            einschalten/auschalten Button
            Button(action:{showProgramm = true}){
                HStack{
                    ZStack{
                        Rectangle().foregroundColor(.teal)
                            .frame(width: 110, height: 40)
                            .cornerRadius(19)
                        
                        Text("start").bold().foregroundColor(.white)
                    }

                }
            }.padding([.bottom], 40)
                .sheet(isPresented: $showProgramm){
                    WasherProgrammControl()
                }
            
            HStack{
                
            
            Rectangle().foregroundColor(.teal)
                .frame(width: 10)
                .cornerRadius(12)
            VStack{
                HStack{
//                    Image(systemName: "lightbulb.fill")
                    Text("Waschmaschine")
                    Spacer()
                }.font(.largeTitle)
                    .bold()
                    .padding([.bottom], 1)
                
                HStack{
                    Text("Waschraum")
                    Spacer()
                }.foregroundColor(.gray)
                    .bold()
                    
                
                HStack{
                        
//                            .foregroundColor(Color(uiColor: UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)))
                    Text("läuft gerade")
                    Spacer()
                }
                
            }
            }.frame(height: 100)
                .padding()
        }
        Spacer()
        
    }
}

