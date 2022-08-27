//
//  MicrowaveControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct MicrowaveControl: View {
    @Binding var microwave: Microwave
    
    var body: some View {
        Text(String(describing: microwave))
    }
}
