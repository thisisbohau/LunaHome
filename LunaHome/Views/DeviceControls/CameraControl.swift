//
//  CameraControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct CameraControl: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var camera: Camera
    
    @State var motionDetection: Bool = true
    @State var push: Bool = true
    @State private var scale = 1.0
    
    var cameraImage: some View{
        VStack{
            Image("Doorbell")
                .resizable()
                .aspectRatio(contentMode: .fit)

        }
    }
    var body: some View {
        VStack{
            HStack{
                ZStack{
                    Circle().foregroundStyle(.tertiary)
                        .frame(width: 30)
                    Image(systemName: "web.camera").foregroundStyle(.secondary)
                    
                }
                
                Text("Kamera").foregroundColor(.gray).bold()

                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.secondary, .tertiary)
                        .foregroundColor(.primary)
                }
                
            }.padding([.leading, .top, .trailing], 20)


        
        cameraImage
        
        HStack{
            Rectangle().foregroundColor(.accentColor)
                .frame(width: 10)
                .cornerRadius(12)

                
            VStack{
                HStack{
//                    Image(systemName: "lightbulb.fill")
                    Text("Einfahrt")
                    Spacer()
                }.font(.largeTitle)
                    .bold()
                    .padding([.bottom], 1)
                
                HStack{
                    Text("Garten")
                    Spacer()
                }.foregroundColor(.gray)
                    .bold()
                    
                
                    HStack{
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            
//                            .foregroundColor(Color(uiColor: UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)))
                        Text("gesichert").bold()
                        Spacer()
                    }
            }.padding([.leading], 5)
              
//            Voice Circle
            Button(action: {}){
                ZStack{
                    Circle().foregroundColor(.accentColor)
                        .frame(width: 60)
                    Image(systemName: "mic.fill").font(.title).foregroundColor(.primary)
                }
            }
            

            
            }.frame(height: 100)
            .padding()
//                .padding([.top],10)
                .padding([.bottom], 15)
            
//            Motion Detection Info
            VStack{
                HStack{
                    ZStack{
                        Circle().foregroundColor(.accentColor).frame(width: 60)
                        Image(systemName: "figure.walk.motion").font(.title)
                    }.padding([.trailing])
                    VStack(alignment: .leading){
                        Text("10:35").font(.title).bold()
                        Text("Bewegung erkannt").foregroundColor(.gray)
                    }
                    
                    Spacer()
                }.padding()
                
            }
            
//          Person Detection Info
            VStack{
                HStack{
                    ZStack{
                        Circle().foregroundColor(.accentColor).frame(width: 60)
                        Image(systemName: "person.fill.viewfinder").font(.title)
                    }.padding([.trailing])
                    VStack(alignment: .leading){
                        Text("Postbote").font(.title).bold()
                        Text("Person erkannt").foregroundColor(.gray)
                    }
                    
                    Spacer()
                }.padding()
                
            }
        }
        
        VStack {
            Toggle("Bewegungserkennung", isOn: $motionDetection)
            Toggle("Push Benachrichtigungen", isOn: $push)


        }.padding()
            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
        
        Spacer()
    }
}
