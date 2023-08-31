//
//  OpenWeatherModel.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/21.
//

import Foundation

/// 地域別の天気情報モデル
struct OpenWeatherModel: Codable {
    
    var list: [WeatherList]
    var city: City
}

struct WeatherList: Codable {
    
    /// タイムスタンプ
    var dt: Int
    /// 温度情報
    var main: MainInfo
    /// 天気情報
    var weather: [Weather]
    /// 日時
    var dt_txt: String
}

struct City: Codable {
    
    /// 都市名
    var name: String
}

struct MainInfo: Codable {
    
    /// 気温
    var temp: Float
    /// 最低気温
    var temp_min: Float
    /// 最高気温
    var temp_max: Float
}

struct Weather: Codable {
    
    /// 天気
    var main: String
    /// 天気の説明(晴れ時々曇りなどの詳細)
    var description: String
    /// 天気のアイコン
    var icon: String
}
