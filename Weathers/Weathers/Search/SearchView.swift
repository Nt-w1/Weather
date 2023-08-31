//
//  SearchView.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/31.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var presenter: SearchPresenter
    
    var body: some View {
        
        List {
            
            Text("緯度経度で検索")
                .onTapGesture {
                    
                    presenter.onTapSearchButton(searchType: .latAndLon)
                }
            
            Text("地域名で検索")
                .onTapGesture {
                    
                    presenter.onTapSearchButton(searchType: .region)
                }
                .alert(isPresented: $presenter.isShowAlert, content: presenter.alertBuilder)
                
        }
        .navigationBarTitle("Setting", displayMode: .inline)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        
        SearchView(presenter: SearchPresenter())
    }
}
