//
//  WeatherListRouter.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/31.
//

import SwiftUI

/// 画面遷移のイベントを管理する
final class WeatherListRouter {
    
    /// 遷移先の詳細画面を返す
    /// - Parameter region: 天気を表示する地域
    /// - Returns: 詳細画面
    func makeDetailView(region: DefaultRegion) -> some View {
        
        let presenter = WeatherDetailPresenter(region: region)
        let detail = WeatherDetailView(presenter: presenter)
        return detail
    }
    
    /// モーダルで表示する検索Viewを検索タイプに応じて返す
    /// - Parameter searchType: 検索タイプ
    /// - Returns: 検索タイプに応じた検索View
    func makeWeatherSearchView(searchType: SearchType) -> some View {
        
        return WeatherSearchview(searchType: searchType)
    }
}

struct FrogsListRouter_Previews: PreviewProvider {
    
    static var previews: some View {
        
        /// プレビューでは東京の情報を表示する
        WeatherListRouter().makeDetailView(region: .tokyo)
    }
}
