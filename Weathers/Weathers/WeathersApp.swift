//
//  WeathersApp.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/15.
//

import Foundation
import SwiftUI

///アプリ起動時のライフサイクル
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        /// デフォルトで表示する地域の天気情報を取得する
        DefaultRegion.allCases.forEach { region in
            
            let weatherForecastInfo = OpenWeatherInfo()
            weatherForecastInfo.fetchOpenWeatherInfo(region: region ,searchType: .region, completion: { model in
                
                // UDに天気情報を保存する
                weatherForecastInfo.saveOpenWeatherInfo(model: model, type: region.rawValue)
            })
        }
        
        return true
    }
}


@main
struct WeathersApp: App {
    
    /// AppDelegateを使うために宣言
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            
            // 表示する地域のリストを持たせる
            HomeView(regions: DefaultRegion.allCases)
        }
    }
}
