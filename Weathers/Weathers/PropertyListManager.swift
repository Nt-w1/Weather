//
//  PropertyListManager.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/23.
//

import Foundation

/// plistの読み込みを行う
final class PropertyListManager {
    
    static let shared = PropertyListManager()
    
    /// OpenWeatherAPIのAPIkeyをplistから読み込む
    /// - Returns: String apikeyを返す
    func getOpenWeatherAPIkey() -> String? {
        
        guard let filePath = Bundle.main.path(forResource: "apikey", ofType: "plist") else { return nil }
        
        guard let plist = NSDictionary(contentsOfFile: filePath) as? [String: String] else { return nil }
        
        return plist["openWeatherAPIKEY"]
    }
}

