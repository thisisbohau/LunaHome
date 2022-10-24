//
//  OvenControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct OvenControl: View {
    @EnvironmentObject var fetcher: Fetcher
    
    
    
    @State var button: Bool = false
    
    var body: some View {

        ZStack{

            
            
            VStack{
                HStack{
                    Image(systemName: "oven.fill").foregroundColor(.gray)
                    Text("Ofen").bold().foregroundColor(.gray)
                    
                    Spacer()
                }.padding()
                    .padding([.bottom], 40)
                
                if button == true{
                    HStack{
                        Image(systemName: "flame.fill").font(.title).foregroundColor(.orange)
                        Text("180°").font(.title).foregroundColor(.primary).bold()
                    }
                }
               
                ZStack{
                    Rectangle()
                        .frame(width: 200, height: 170)
                        .cornerRadius(15)
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(width: 300, height: 10 )
                        .offset(y: -48)
                        .foregroundColor(Color(UIColor.systemBackground))
                    Circle()
                        .frame(width: 15)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .offset(x: -80, y: -68)
                    
                    Circle()
                        .frame(width: 15)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .offset(x: -55, y: -68)
                    
                    if button == true{

                        LinearGradient(colors: [.orange, .yellow] , startPoint: .top, endPoint: .bottom)
                            .frame(width: 130, height: 75 )
                            .clipShape(Rectangle())
                            .cornerRadius(10)
                            .offset(y: 17)
                            
                    }else{
                        Rectangle()
                            .frame(width: 130, height: 75)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .offset(y: 17)
                    }
                    
                    
                        
                    
                }
                .padding()
                

                Button(action:{button.toggle()}){
                    ZStack{
                        
                        Rectangle().foregroundColor(.accentColor)
                            .frame(width: 110, height: 40)
                            .cornerRadius(19)
                        if button == true{
                            Text("stop").bold().foregroundColor(.white)
                        }else{
                            Text("start").bold().foregroundColor(.white)
                        }
                        
                        
                    }.padding([.top], 30)
                }
                HStack{
                    Text("Coming Soon: Programmauswahl")
                }.padding([.top])
                .padding([.bottom], 50)
                
                HStack{
                    
                    
                    Rectangle().foregroundColor(.accentColor)
                        .frame(width: 10)
                        .cornerRadius(12)
                    VStack{
                        HStack{
                            //                    Image(systemName: "lightbulb.fill")
                            Text("Ofen")
                            Spacer()
                        }.font(.largeTitle.bold())
                            
                            .padding([.bottom], 1)
                        
                        HStack{
                            Text("Küche")
                                .bold()
                            Spacer()
                        }.foregroundColor(.gray)
                            
                        
                        
                        HStack{
                            if button == true{
                                Text("ein")
                            }else{
                                Text("aus")
                            }
                          
                            Spacer()

                        }
                        
                        
                        
                    }
                    
                }.frame(height: 100)
                    .padding()
                
                if button == true{
                    VStack{
                        HStack{
                            ZStack{
                                Circle().foregroundColor(.accentColor).frame(width: 60)
                                Image(systemName: "flame.fill").font(.title)
                            }.padding([.trailing])
                            VStack(alignment: .leading){
                                Text("Vorheizen 180°").font(.title).bold()
                                Text("Modus").foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }.padding()
                        
                    }
                }
                
                Spacer()
                
            }
        }
    }
}

