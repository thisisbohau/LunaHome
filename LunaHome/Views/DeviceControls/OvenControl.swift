//
//  OvenControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct OvenControl: View {
    @Binding var oven: Oven
    
    var body: some View {
        Text(String(describing: oven))
    }
}

