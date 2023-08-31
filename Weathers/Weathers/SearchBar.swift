//
//  SearchBar.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            
            ZStack {
                
                // 背景
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 239 / 255,
                                green: 239 / 255,
                                blue: 241 / 255))
                    .frame(height: 36)
                
                HStack(spacing: 6) {
                    Spacer()
                        .frame(width: 0)
                    
                    // 虫眼鏡
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    // テキストフィールド
                    TextField("Search", text: $text)
                    
                    // 検索文字が空ではない場合は、クリアボタンを表示
                    if !text.isEmpty {
                        
                        Button {
                            
                            text.removeAll()
                        } label: {
                            
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 6)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

