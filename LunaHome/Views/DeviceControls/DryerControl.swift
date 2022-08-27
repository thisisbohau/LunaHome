//
//  DryerControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct DryerControl: View {
    @Binding var dryer: Dryer
    
    var body: some View {
        Text(String(describing: dryer))
    }
}

