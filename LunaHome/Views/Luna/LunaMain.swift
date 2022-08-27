//
//  LunaMain.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 27.08.22.
//

import SwiftUI

struct LunaMain: View {
    @State var animateGradient: Bool = false
    
    
    var lunaWelcome: some View{
        VStack(alignment: .leading){
            
            VStack{
                Text("Hallo ich bin\nluna.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 45))
                    .fontWeight(.semibold)
                    .padding()
                Text("Ich habe stets ein Auge auf dein Zuhause, stehe dir bei Problemen zur Seite und achte darauf, dass du immer ein komfortables Zuhause hast.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.regularMaterial)
                
                HStack{
                    Spacer()
                    Image(systemName: "moonphase.first.quarter.inverse")
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(.thinMaterial)
                    Spacer()
                }
               
            }
            .padding()
            .padding(.bottom)
            .background(
                LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
//                    .overlay(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                  
                
            )
            .cornerRadius(30)
            
        }
    }
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Text("Luna")
                    .font(.headline)
                Spacer()
            }
            .padding()
            
            
            Spacer()
            
        
                ScrollView{
                    lunaWelcome
                        .padding(.bottom)
                        .padding(.top, 80)
                    HStack{
                        Text("Meine Tipps")
                            .font(.title3.bold())
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    LunaTips()
                }
            }
            .padding()
        }
    }


struct LunaMain_Previews: PreviewProvider {
    static var previews: some View {
        LunaMain()
    }
}
