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
    
    
    
    var rectangle: some View{
        Rectangle()
            .cornerRadius(10)
            .frame(width: 190, height: 40)
    }
    
    var circles: some View{
        VStack{
            Circle()
                .foregroundColor(Color.gray)
                .frame(width: 15)
            Circle()
                .foregroundColor(Color.gray)
                .frame(width: 15)
        }
    }
    
    var body: some View {
       
        ZStack{
            VStack{
                Rectangle()
                    .foregroundStyle(.regularMaterial)
                    .cornerRadius(25)
                    .padding()
                
            }
            .padding([.bottom], 260)
            
            
            VStack{
                Spacer()
                Rectangle()
                    .foregroundColor(.secondary)
                    .cornerRadius(20)
                    .frame(width: 220, height: 22)
                
                HStack{
                    circles
                    if blind.position > 0{
                        rectangle
                            .foregroundColor(.orange)
                    }else{
                        rectangle
                            .foregroundColor(.secondary)
                    }
                    
                    
                    
                    
                }
                HStack{
                    circles
                    if blind.position > 25{
                        rectangle
                            .foregroundColor(.orange)
                    }else{
                        rectangle
                            .foregroundColor(.secondary)
                    }
                    
                }
                HStack{
                    circles
                    
                    if blind.position > 50{
                        rectangle
                            .foregroundColor(.orange)
                    }else{
                        rectangle
                            .foregroundColor(.secondary)
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
                            .foregroundColor(.orange)
                    }else{
                        rectangle
                            .foregroundColor(.secondary)
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
                        }
                    )
                    
                }
                .accentColor(Color.orange)
                .padding([.leading, .trailing])
                
                
                HStack{
                    Text("offen").bold().foregroundStyle(.secondary)
                    Spacer()
                    Text("geschlossen").bold().foregroundStyle(.secondary)
                }.padding([.leading, .trailing])
                
                
                
                
            }
            .padding()
//            .padding([.bottom],330)
            VStack{
                Spacer()
                if blind.closed{
                    Text("geschlossen")
                }else{
                    Text("offen")
                }
                
            }
            
            
            
            
            
        }
        
    
        
        
    }
}
