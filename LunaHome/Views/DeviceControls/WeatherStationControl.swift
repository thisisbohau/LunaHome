//
//  WeatherStationControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct WeatherStationControl: View {
    @Binding var weatherStation: WeatherStation
    
    var body: some View {
        Text(String(describing: weatherStation))
    }
}
