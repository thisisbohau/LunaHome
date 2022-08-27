//
//  DoorLockControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct DoorLockControl: View {
    @Binding var doorLock: DoorLock
    
    var body: some View {
        Text(String(describing: doorLock))
    }
}
