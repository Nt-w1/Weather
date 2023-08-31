//
//  WeatherListView.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/21.
//

import SwiftUI

/// 地域別天気情報を表示するView
struct WeatherListView: View {
    
    /// 検索キーワード
    @State private var searchKeyWord: String = ""
    
    /// 検索モダールの表示/非表示管理
    @State var isShowSearchModal = false
    
    /// Presenterの保持
    @ObservedObject var listPresenter: WeatherListPresenter
    
    /// 最初に表示する地域のリスト
    var regions: [DefaultRegion] = DefaultRegion.allCases
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(0..<listPresenter.regions.count) { num in
                    
                    self.listPresenter.linkBuilder(region: listPresenter.regions[num], completion: {
                        
                        // リストには地域名を表示する
                        Text("\(DefaultRegion.allCases[num].rawValue)")
                    })
                }
            }// 検索バー
            .searchable(text: $searchKeyWord, prompt: "都市名で検索")
            .onSubmit {
                
                // 検索ワードでopenWeatherAPIコールをする
                OpenWeatherInfo().fetchOpenWeatherInfoByRegionName(regionName: searchKeyWord) { model in
                    
                    // 検索成功した場合、保存する
                    OpenWeatherInfo().saveOpenWeatherInfo(model: model, type: searchKeyWord)
                }
            }
        }
        .navigationBarItems(trailing: self.makeSearchButton())
    }
    
    /// 検索ボタンの作成
    /// - Returns: 検索ボタン
    func makeSearchButton() -> some View {
        
        Button {
            
            // 押されたらモーダルを表示する
            self.isShowSearchModal.toggle()
        } label: {
            
            Image(systemName: "magnifyingglass")
        }
        .sheet(isPresented: $isShowSearchModal) {
            
            listPresenter.onTapSearchButton(searchType: .latAndLon)
                .toolbar {
                    
                    Button("Close", role: .cancel) {
                        
                        // 押されたらモーダルを閉じる
                        self.isShowSearchModal.toggle()
                    }
                }
        }
    }
}
