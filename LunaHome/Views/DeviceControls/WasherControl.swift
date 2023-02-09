//
//  WasherControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct WasherControl: View {
    @EnvironmentObject var fetcher: Fetcher
    
    @State var showProgramm: Bool = false
    @State var animate: Bool = false
    
    
   
    func start(){
//        fetcher.start()
    }
    
//    washer: Washer(state: false, runTime: 0, programm: "", health: [String](), beschmutzung: "", temperatur: "", schleudern: "")
    
    func setupOnAppear(){
        withAnimation(.linear(duration: 1).repeatForever()){
            animate.toggle()
        }
    }
    
    var body: some View {
        ScrollView{
            ZStack{
                
                
                VStack{
                    HStack{
                        Image(systemName: "washer.fill").foregroundColor(.gray)
                        Text("Waschmaschine").bold().foregroundColor(.gray)
                        
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
                                .foregroundStyle(.tertiary)
                        }.offset(y:20)
                        VStack{
                            LinearGradient(colors: [fetcher.data.washer.state ? .blue : .teal, .teal], startPoint: .top, endPoint: .bottom)
                                .frame(width: 80, height: 80)
                            
                                .clipShape(Circle())
                                .rotationEffect(Angle(degrees: animate ? 360 : 0))
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
                    
                    
                    if fetcher.data.washer.state == false{
                        Button(action:{showProgramm = true}){
                            HStack{
                                ZStack{
                                    Rectangle().foregroundColor(.teal)
                                        .frame(width: 110, height: 40)
                                        .cornerRadius(19)
                                    
                                    Text("start").bold().foregroundColor(.white)
                                }
                                
                            }
                        }.padding([.bottom], 20)
                            .sheet(isPresented: $showProgramm){
                                WasherProgrammControl()
                            }
                    }else{
                        Button(action:{fetcher.data.washer.state = false}){
                            HStack{
                                ZStack{
                                    Rectangle().foregroundColor(.teal)
                                        .frame(width: 110, height: 40)
                                        .cornerRadius(19)
                                    
                                    Text("beenden").bold().foregroundColor(.white)
                                }
                                
                            }
                        }.padding([.bottom], 20)
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
                            }.font(.largeTitle.bold())
                                
                                .padding([.bottom], 1)
                            
                            HStack{
                                Text("Waschraum")
                                    .bold()
                                Spacer()
                            }.foregroundColor(.gray)
                                
                            
                            
                            HStack{
                                
                                if fetcher.data.washer.state == true{
                                    Text("läuft gerade")
                                    Spacer()
                                }else{
                                    Text("aus")
                                    Spacer()
                                }
                                
                            }
                            
                            
                            
                        }
                        
                    }.frame(height: 100)
                        .padding()
                    
                    
                    //            Statusanzeigen
                    
                    if fetcher.data.washer.state == true{
                        VStack{
                            VStack{
                                HStack{
                                    //                        ZStack{
                                    //                            Circle().foregroundColor(.teal).frame(width: 60)
                                    //                            Image(systemName: "washer.fill").font(.title).foregroundColor(.white)
                                    //                        }.padding([.trailing])
                                    
                                    Image(systemName: "washer.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Circle().foregroundColor(.teal))
                                    VStack(alignment: .leading){
                                        Text(fetcher.data.washer.programm).font(.title).bold()
                                        Text("Waschprogramm").foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                
                            }.padding([.bottom])
                            
                            VStack{
                                HStack{
                                    //                        ZStack{
                                    //                            Circle().frame(width: 60).foregroundColor(.teal)
                                    //                            Image(systemName: "timer").font(.title).foregroundColor(.white)
                                    //                        }.padding([.trailing])
                                    
                                    Image(systemName: "timer")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Circle().foregroundColor(.teal))
                                    VStack(alignment: .leading){
                                        Text("\(Text(fetcher.washerStartedAt, style: .timer)) Minuten").font(.title).bold()
                                        Text("Läuft seit").foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                
                            }.padding([.bottom])
                            
                            VStack{
                                HStack{
                                    //                        ZStack{
                                    //                            Circle().foregroundColor(.teal).frame(width: 60)
                                    //                            Image(systemName: "waveform.path.ecg").font(.title).foregroundColor(.white)
                                    //                        }.padding([.trailing])
                                    
                                    Image(systemName: "waveform.path.ecg")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Circle().foregroundColor(.teal))
                                    VStack(alignment: .leading){
                                        Text("Bitte Reinigen").font(.title).bold()
                                        Text("Zustand").foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                
                            }
                        }.padding()
                    }else{
                        VStack{
                            HStack{
                                //                        ZStack{
                                //                            Circle().foregroundColor(.teal).frame(width: 60)
                                //                            Image(systemName: "waveform.path.ecg").font(.title)
                                //                        }.padding([.trailing])
                                
                                Image(systemName: "waveform.path.ecg")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Circle().foregroundColor(.teal))
                                VStack(alignment: .leading){
                                    Text("Bitte Reinigen").font(.title).bold()
                                    Text("Zustand").foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                            
                        }.padding()
                    }
                    Spacer()
                }
            }
            .onAppear(perform: setupOnAppear)
        }
    }
}

