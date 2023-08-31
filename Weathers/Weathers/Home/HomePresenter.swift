//
//  HomePresenter.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/29.
//

import Foundation

protocol HomePresentation: AnyObject {
    
    /// 検索ボタンが押されたとき
    func didTappedSearchBtn()
}

/// Home画面でのイベントを管理する
final class HomePresenter: ObservableObject {
    
    /// 表示する地域のリスト
    private let regions: [DefaultRegion]
    
    init(regions: [DefaultRegion]) {
        
        self.regions = regions
    }
}

extension HomePresenter: HomePresentation {
    
    func didTappedSearchBtn() {
        
    }
}
