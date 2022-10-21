//
//  LunaPrivacy.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 08.09.22.
//

import SwiftUI

struct LunaPrivacy: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Datenschutz")
                    .font(.headline)
                Spacer()
            }
            .padding()
            .padding(.top)
            ScrollView{
                Text("Luna legt großen Wert auf deine Privatsphäre. Alle personenbezogenen Daten werden nur auf deinem lokalen Server gespeichert. Informationen wie Nutzungsdaten und Suchanfragen werden als Trainingsdaten für Luna verwendet.")
                
                VStack(alignment: .leading){
                    Text("Lokal verschlüsselt und nur durch dich einsehbar:")
                        .bold()
                    Text("... Anwesenheitshistorie")
                    Text("... Anschrift")
                    Text("... Passwörter")
                    Text("... Türschloss Zugang")
                    HStack{
                        Spacer()
                    }
                }
                .padding(22)
                .background(Color("fill"))
                .cornerRadius(30)
                
                VStack(alignment: .leading){
                    Text("Anonymisiert und nur für Luna's Trainingszwecke:")
                        .bold()
                    Text("... Fehlerhistorie")
                    Text("... Wetterstatistiken")
                    Text("... Bevorzugte Einstellungen")
                    Text("... Absturzberichte")
                    HStack{
                        Spacer()
                    }
                }
                .padding(22)
                .background(Color("fill"))
                .cornerRadius(30)
                
                VStack(alignment: .leading){
                    Text("Daten, welche als Trainingsdaten verwendet werden, enthalten keinerlei persönliche Informationen und sind auch nicht mit deiner Identität verknüpft. Diese Daten verlassen in keinem Fall den eigenständigen Lernprozess von Luna.")
                        .bold()
                    
                    HStack{
                        Spacer()
                    }
                }
                .padding(22)
                .background(Color("fill"))
                .cornerRadius(30)
                .padding(.top)
                
                Spacer()
            }.padding()
        }
        .background(Color("background").ignoresSafeArea())
    }
}

struct LunaPrivacy_Previews: PreviewProvider {
    static var previews: some View {
        LunaPrivacy()
    }
}
