//
//  WeatherSearchView.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/31.
//

import SwiftUI

/// モーダルで表示する検索View
struct WeatherSearchview: View {
    
    /// 検索ワード
    @State var searchWord = ""
    /// 緯度経度で2つ目のワードを使う時
    @State var secondWord = ""
    
    /// 検索タイプ
    var searchType: SearchType
    
    init(searchType: SearchType) {
        
        self.searchType = searchType
    }
    
    @ViewBuilder
    var body: some View {
        
        // 検索タイプによって表示するviewを変更する
        switch searchType {
        case .region:
            
            regionSearchView
            
        case .latAndLon:
            
            latAndLonSearchView
        }
    }
    
    /// 地域名で検索するとき
    var regionSearchView: some View {
        
        TextField("地域名を入力してください", text: $searchWord)
    }
    
    
    /// 緯度経度で検索するとき
    var latAndLonSearchView: some View {
        
        HStack {
            
            TextField("緯度を入力してください", text: $searchWord)
            TextField("経度を入力してください", text: $secondWord)
        }
    }
}

