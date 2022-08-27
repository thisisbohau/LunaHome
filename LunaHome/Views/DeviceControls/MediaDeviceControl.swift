//
//  MediaDeviceControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

struct MediaDeviceControl: View {
    @Binding var mediaDevice: MediaDevice
    
    var body: some View {
        Text(String(describing: mediaDevice))
    }
}
