//
//  BlindControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct BlindControl: View {
    @Binding var blind: Blind
    @State var blindPosition: Double = 0
    @State private var isEditing = false
    @State var numbersInput: Double = 1
 
    
    func setup(){
        blindPosition = Double(blind.position)
    }
    
//    Update beim Ändern der Position
    
    func updatePosition(){
        blind.position = Int(blindPosition)
    }
    
    
    
    var rectangle: some View{
        Rectangle()
            .cornerRadius(10)
            .frame(width: 190, height: 40)
    }
    
    var circles: some View{
        VStack{
            Circle()
                .foregroundColor(Color.secondary)
                .frame(width: 15)
            Circle()
                .foregroundColor(Color.secondary)
                .frame(width: 15)
        }
    }
    var control: some View{
        VStack{
            Rectangle()
                .foregroundColor(.secondary)
                .cornerRadius(20)
                .frame(width: 220, height: 22)
            
            HStack{
                circles
                if blind.position > 0{
                    rectangle
                        .foregroundColor(.teal)
                }else{
                    rectangle
                        .foregroundColor(.gray.opacity(0.2))
                }
                
                
                
                
            }
            HStack{
                circles
                if blind.position > 25{
                    rectangle
                        .foregroundColor(.teal)
                }else{
                    rectangle
                        .foregroundColor(.gray.opacity(0.2))
                }
                
            }
            HStack{
                circles
                
                if blind.position > 50{
                    rectangle
                        .foregroundColor(.teal)
                }else{
                    rectangle
                        .foregroundColor(.gray.opacity(0.2))
                }
            }
            HStack{
                VStack{
                    Rectangle()
                        .foregroundColor(Color.gray)
                        .frame(width: 14, height: 35)
                        .cornerRadius(12)
                    
                }
                
                
                if blind.position > 75{
                    rectangle
                        .foregroundColor(.teal)
                }else{
                    rectangle
                        .foregroundColor(.gray.opacity(0.2))
                }
                
                
                
            }
            .padding([.bottom])
            
            HStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .foregroundColor(.secondary)
                        .cornerRadius(12)
                        .frame(width: 55, height: 30)
                        .padding()
                    Text("\(Int(blindPosition))%")
                        .foregroundColor(Color.white)
                }.padding([.bottom], -10)
                
                
                
                
            }
            VStack{
                Slider(
                    value: $blindPosition,
                    in: 0...100,
                    onEditingChanged: { editing in
                        isEditing = editing
                        updatePosition()
                    }
                )
                
            }
            
            .padding([.leading, .trailing])
            
            
            HStack{
                Text("offen").bold().foregroundStyle(.secondary)
                Spacer()
                Text("geschlossen").bold().foregroundStyle(.secondary)
            }.padding([.leading, .trailing])
            
            
            
            
        }
        .padding()
    }
    
    var body: some View {
    
        GeometryReader{ geometry in
        ZStack{
            
            VStack{
                control
                    .padding(.top, 50)
                Spacer()
            }
            

//            .padding([.bottom], geometry.size.height )
//            VStack{
//                Spacer()
//                if blind.closed{
//                    Text("geschlossen")
//                }else{
//                    Text("offen")
//                }
//
//            }
            
            
            
            
            
        }.background(.regularMaterial)
        
    
        
        
    }
        .accentColor(Color.teal)
    }
}
