//
//  WasherControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct WasherControl: View {
    @Binding var washer: Washer
    
    var body: some View {
        Text(String(describing: washer))
    }
}

