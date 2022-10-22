//
//  AirQuality.swift
//  LunaHome
//
//  Created by Carina Schmidinger on 21.10.22.
//

import SwiftUI

struct AirQuality: View {
    var body: some View {
        VStack{
            HStack{
                Text("Luftqualität")
            }.padding()
            .background(Color.gray)
            .cornerRadius(12)
                
        }
        
    }
}

struct AirQuality_Previews: PreviewProvider {
    static var previews: some View {
        AirQuality()
    }
}
