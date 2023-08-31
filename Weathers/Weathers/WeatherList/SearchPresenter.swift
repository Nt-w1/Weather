//
//  SearchPresenter.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/31.
//

import SwiftUI

protocol SearchPresentation {
    
    /// 検索ボタンが押されたとき
    /// - Parameter searchType: 検索するキーワードの種類
    func onTapSearchButton(searchType: SearchType)
}


final class SearchPresenter: ObservableObject {
    
}

