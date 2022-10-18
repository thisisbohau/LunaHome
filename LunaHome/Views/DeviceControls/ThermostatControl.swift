//
//  ThermostatControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct ThermostatControl: View {
    @Binding var thermostat: Thermostat
    @EnvironmentObject var fetcher: Fetcher
    
    var body: some View {
        VStack{
            Text(String(describing: thermostat))
            Text("helloooo")
        }
    }
}

