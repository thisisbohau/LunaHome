//
//  ThermostatControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct ThermostatControl: View {
    @Binding var thermostat: Thermostat
    
    var body: some View {
        Text(String(describing: thermostat))
    }
}

