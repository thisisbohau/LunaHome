//
//  DishwasherControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct DishwasherControl: View {
    @Binding var dishwasher: Dishwasher
    
    var body: some View {
        Text(String(describing: dishwasher))
    }
}
