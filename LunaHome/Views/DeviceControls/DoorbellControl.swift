//
//  DorbellControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct DoorbellControl: View {
    @Binding var doorbell: Doorbell
    
    var body: some View {
        Text(String(describing: doorbell))
    }
}
