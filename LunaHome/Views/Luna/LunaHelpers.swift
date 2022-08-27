//
//  LunaHelpers.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 27.08.22.
//

import Foundation
import SwiftUI

struct LunaEntry: Identifiable, Codable{
    var id: String
    var title: String
    var message: String
    var priority: Int
    var image: String
    var color: String
}

class Luna{
    func getColor(string: String) -> Color{
        switch string{
        case "pink":
            return .pink
        case "orange":
            return .orange
        case "blue":
            return .blue
        case "teal":
            return .teal
        case "accent":
            return .accentColor
        default:
            return .gray
        }
    }
}
