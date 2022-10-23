//
//  WelcomeView.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 22.10.22.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var fetcher: Fetcher
    @State var name: String = ""
    @State var animateGradient: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    func save(){
        SettingsData().saveName(name: name)
        fetcher.showSetup = false
        presentationMode.wrappedValue.dismiss()
    }
    
    func setup(){
        name = SettingsData().getUserName()
    }
    var background: some View{
        ZStack{
            LinearGradient(colors: [.accentColor, .accentColor, Color("GradientSecondary")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        }
    }
    var body: some View {
        VStack{
            Text("Willkommen Zuhause")
                .font(.largeTitle.bold())
            Spacer()
            
            Image("luna")
                .font(.system(size: 100))
                
            Text("Hallo! Ich bin Luna, dein persönlicher Assistent für alles, was dein Zuhause betrifft. Kannst du mir noch deinen Namen verraten, bevor wir loslegen?")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            TextField("Dein Name", text: $name)
                .padding(10)
                .background(.regularMaterial)
                .cornerRadius(12)
            Spacer()
            
            Button(action: save){
                HStack{
                    Spacer()
                    Text("Los Gehts")
                        .font(.body.bold())
                    Spacer()
                }
                
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(18)
            .padding()
        }
        .onAppear(perform: setup)
        .padding()
        .padding(.top)
        .background(background.ignoresSafeArea())
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
