//
//  BlindControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct BlindControl: View {
    @Binding var blind: Blind
    @State var blindPosition: Float = 0
    @State private var isEditing = false
    @State var numbersInput: Double = 1
    @State var sliderColor: Color = .teal
    
    func setup(){
        blindPosition = Float(100-blind.position)
    }
    
//    Update beim Ändern der Position
    
    func updatePosition(){
        blind.position = Int(100-blindPosition)
        if blind.position == 0{
            blind.closed = true
        }else{
            blind.closed = false
        }
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
                .frame(width: 15, height: 15)
            Circle()
                .foregroundColor(Color.secondary)
                .frame(width: 15, height: 15)
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
                if blind.position < 100{
                    rectangle
                        .foregroundColor(.teal)
                }else{
                    rectangle
                        .foregroundColor(.gray.opacity(0.2))
                }
            }
            HStack{
                circles
                
                if blind.position < 50{
                    rectangle
                        .foregroundColor(.teal)
                }else{
                    rectangle
                        .foregroundColor(.gray.opacity(0.2))
                }
                
            }
            HStack{
                circles
                
                if blind.position < 25{
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
                
                
                if blind.position < 5{
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
//                    Rectangle()
//                        .foregroundStyle(.regularMaterial)
//                        .cornerRadius(12)
//                        .frame(width: 55, height: 30)
//                        .padding()
                    if blind.closed{
                        Text("geschlossen")
                    }else if blind.position == 100{
                        Text("geöffnet")
                    }else{
                        Text("\(Int(100-blindPosition))%")
                    }
                        
                }
                .padding(10)
                .background(.regularMaterial)
                .cornerRadius(12)
                .padding([.bottom], -10)
                
                
                
                
                
            }
//            VStack{
//                Slider(
//                    value: $blindPosition,
//                    in: 0...100,
//                    onEditingChanged: { editing in
//                        isEditing = editing
//                        updatePosition()
//                    }
//                )
//
//            }
     
            
            
            
        }
        .padding()
    }
    
    var body: some View {
//        ScrollView{
        GeometryReader{ geometry in
            ZStack{
                
                
                VStack{
                    HStack{
                        Text("Rollo Steuerung").foregroundColor(.gray).bold()
                        
                        Spacer()
                    }.padding()
                    
                    control
                        .padding(.top, 50)
                    
                    VerticalSlider(size: CGSize(width: geometry.size.width*0.92, height: 20), value: $blindPosition, lineColor: $sliderColor, onChange: updatePosition)
                        
                      
                        .cornerRadius(8)
                    
                    .padding([.leading, .trailing])
                    
                    
                    HStack{
                        Text("offen").bold().foregroundStyle(.secondary)
                        Spacer()
                        Text("geschlossen").bold().foregroundStyle(.secondary)
                    }.padding([.leading, .trailing])
                    
                    HStack{
                        Rectangle().foregroundColor(.teal)
                            .frame(width: 10)
                            .cornerRadius(12)

                            
                        VStack{
                            HStack{
                                Text(blind.name)
                                Spacer()
                            }.font(.largeTitle)
                                .bold()
                                .padding([.bottom], 1)
                            
                            HStack{
                                Text("Status")
                                Spacer()
                            }.foregroundColor(.gray)
                                .bold()
                                
                            
                            if blind.closed == true{
                                HStack{
                                    Text("geschlossen")
                                    Spacer()
                                }
                                .foregroundColor(.gray)
                                .bold()
                            }else{
                                HStack{
                                    Text("\(blind.position)% offen")
                                    Spacer()
                                }
                               
                            }
                            
                        }
                    }.frame(height: 100)
                        .padding()
                            .padding([.top],50)
                    
                        
                    
                    
                    
                    Spacer()
                }
                .onAppear(perform: setup)
                
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
                
                
                
                
                
            }
            
            
            
            
        }
        .accentColor(Color.teal)
//        .background(.regularMaterial)
//    }
    }
}
