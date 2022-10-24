//
//  SettingsSaver.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 22.10.22.
//

import Foundation

class SettingsData{
    func getUserName() -> String{
        return UserDefaults.standard.string(forKey: "UserName") ?? ""
    }
    
    func saveName(name: String){
        UserDefaults.standard.set(name, forKey: "UserName")
    }
}
