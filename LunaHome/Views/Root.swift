//
//  Root.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 24.08.22.
//

import SwiftUI

struct Root: View {
    @EnvironmentObject var fetcher: Fetcher
    @EnvironmentObject var states: DeviceStates
    @State var setup: Bool = false
    
    init() {
        UITabBar.appearance().tintColor = UIColor.white
    }
    
    func setupTasks(){
        Task{
            await fetcher.load()
            fetcher.logTemplate()
            DispatchQueue.main.async {
                if let room = fetcher.data.rooms.first{
                    states.activeRoom = room
                }else{
                    
                    return
                }
            }
           
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                setup = false
//            })
            
        }
        
    }
    var body: some View {
        VStack{
            if fetcher.showSetup{
                WelcomeView()
            }else if setup{
                VStack{
                    HStack{
                        Spacer()
                    }
                    Spacer()
                    Image("luna")
                        .font(.system(size: 80))
                        .foregroundStyle(.primary)
                    Text("Ich bin gleich soweit.")
                        .padding()
                    ProgressView()
                    Spacer()
                }.background(Color.accentColor.ignoresSafeArea())
            }else{
                TabView{
                    OverviewMain()
                    //                .preferredColorScheme(.dark)
                        .tabItem {
                            Label("Überblick", image: "homeIcon")
                        }
                        .tag(1)
                    
                    LunaMain()
                        .tabItem {
                            Label("Luna", image: "luna")
                            
                        }
                    
                        .tag(2)
                    
                    RoomView(room: $states.activeRoom)
                        .tabItem {
                            Label("Räume", systemImage: "square.on.square")
                        }
                        .tag(23)
                    
                    
                }
                
                
            }
        }
        .onAppear(perform: {
            setupTasks()
            
            
        })
    }
}

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        Root()
            .preferredColorScheme(.light)
            .environmentObject(Fetcher())
    }
}
