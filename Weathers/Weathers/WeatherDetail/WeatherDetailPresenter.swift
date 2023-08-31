//
//  WeatherDetailPresenter.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/31.
//

import SwiftUI

/// 各地の天気の詳細画面でのイベントを検知する
final class WeatherDetailPresenter: ObservableObject {
    
    let region: DefaultRegion
    
    init(region: DefaultRegion) {
        
        self.region = region
    }
    
    func alertBuilder() -> Alert {
        
        let alertButton = Alert.Button.default(Text("OK")) {
            
            print("did tap alert OK button")
        }
        let alert = Alert(title: Text("This feature is out of service"),
                          message: Text("Please wait a little longer for service to begin. It may take a few days."),
                          dismissButton: alertButton)
        return alert
    }
    
    
}
