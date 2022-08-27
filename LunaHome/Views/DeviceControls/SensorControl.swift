//
//  SensorControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct SensorControl: View {
    @Binding var sensor: Sensor
    
    var body: some View {
        Text(String(describing: sensor))
    }
}
