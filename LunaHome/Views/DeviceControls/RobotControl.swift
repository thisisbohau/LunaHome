//
//  RobotControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct RobotControl: View {
    @Binding var robot: Robot
    
    var body: some View {
        Text(String(describing: robot))
    }
}
