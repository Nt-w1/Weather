//
//  WeatherListPresenter.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/31.
//

import SwiftUI

/// 天気情報を表示する地域Listでのイベントを検知する
final class WeatherListPresenter: ObservableObject {
    
    /// WeatherList画面での画面遷移を知らせるため
    private let router = WeatherListRouter()
    
    let regions: [DefaultRegion]
    
    init(regions: [DefaultRegion]) {
        
        self.regions = regions
    }
    
}

// MARK: - WeatherListPresentation
extension WeatherListPresenter {
    
    /// 詳細画面へ遷移するとき
    /// - Parameters:
    ///   - region: 表示する地域
    ///   - completion: 画面遷移前後で表示するView
    /// - Returns: 遷移先の画面を返す
    func linkBuilder<Content: View>(region: DefaultRegion, @ViewBuilder completion: () -> Content) -> some View {
        
        NavigationLink(destination: router.makeDetailView(region: region)) {
            
            completion()
        }
    }
}

// MARK: - SearchPresentation
extension WeatherListPresenter {
    
    /// 検索ボタンが押されたとき
    /// - Parameter searchType: 検索タイプ
    /// - Returns: 返すモーダルView
    func onTapSearchButton(searchType: SearchType) -> some View {
        
        return router.makeWeatherSearchView(searchType: searchType)
    }
}
