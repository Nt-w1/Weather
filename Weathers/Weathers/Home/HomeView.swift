//
//  HomeView.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/15.
//

import SwiftUI

/// ホーム画面
struct HomeView: View {
    
    /// 表示する地域のリスト
    let regions: [DefaultRegion]
    
    init(regions: [DefaultRegion]) {
        
        self.regions = regions
    }
    
    var body: some View {
        
        NavigationView {
            
            // 各地域のリストを表示する
            WeatherListView(listPresenter: WeatherListPresenter(regions: regions))
        }
    }
}

