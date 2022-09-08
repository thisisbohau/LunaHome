//
//  LunaMain.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 27.08.22.
//

import SwiftUI

struct LunaMain: View {
    @EnvironmentObject var fetcher: Fetcher
    @State var animateGradient: Bool = false
    @State var showPrivacy: Bool = false
    
    var predictions: some View{
        VStack{
            HStack{
                Text("Prognosen und Statistik")
                    .font(.title3.bold())
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.top)
            ForEach(fetcher.data.predictions){prediction in
                LunaPredictions(prediction: prediction)
            }
        }
    }
    
    var suggestions: some View{
        VStack{
            HStack{
                Text("Meine Tipps")
                    .font(.title3.bold())
                    .foregroundColor(.secondary)
                Spacer()
            }
            LunaTips()
        }
    }
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
                        .padding(.top)
                    
                    Button(action: {showPrivacy.toggle()}){
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "hand.raised.slash")
                                Text("Datenschutz Bei Luna")
                                Spacer()
                            }
                        }
                        .padding(22)
                        .background(Color("fill"))
                        .cornerRadius(30)
                    }
                   suggestions
                    
                    predictions
                }
            }
            .padding()
            .sheet(isPresented: $showPrivacy){
                LunaPrivacy()
            }
        }
    }
//
//
//struct LunaMain_Previews: PreviewProvider {
//    static var previews: some View {
//        LunaMain()
//    }
//}
