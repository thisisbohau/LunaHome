//
//  BlindControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct BlindControl: View {
    @Binding var blind: Blind
    
    var body: some View {
        Text(String(describing: blind))
    }
}
