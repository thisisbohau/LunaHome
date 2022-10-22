//
//  AirQuality.swift
//  LunaHome
//
//  Created by Carina Schmidinger on 21.10.22.
//

import SwiftUI

struct AirQuality: View {
    var body: some View {
        ScrollView{
            HStack{
                Text("Luftqualität").font(.largeTitle).bold()
                Spacer()
            }
                .padding()
            
            HStack{
                Image(systemName: "aqi.low")
                    .font(.title)
                    .foregroundColor(.green)
                VStack(alignment: .leading){
                    Text("Optimale Luftfeuchte")
                        .font(.title2)
                        .bold()
                    Text("zwischen 40 und 60%")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
                Spacer()
            }
            .padding()
            .background(.regularMaterial)
            .cornerRadius(12)
            .padding()
                    
                
            
            
        }

        
    }
}

struct AirQuality_Previews: PreviewProvider {
    static var previews: some View {
        AirQuality()
    }
}
