//
//  WeatherDetailTabView.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/23.
//

import SwiftUI

/// 週間天気などの詳細な天気情報を表示する画面
struct WeatherDetailView: View {
    
    @ObservedObject var presenter: WeatherDetailPresenter
    
    /// UDに保存している天気情報
    var model: OpenWeatherModel {

        return OpenWeatherInfo().getOpenWeatherInfo(type: presenter.region)
    }
    
    var body: some View {
        
        List {
            
            ForEach(0..<model.list.count) { num in
                
                HStack {
                    
                    weatherIcon(num: num)
                    VStack {
                        
                        dateTime(num: num)
                        HStack {
                            
                            tempMaxLabel(num: num)
                            tempMinLabel(num: num)
                        }
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }

    
    /// 最高気温のラベル
    func tempMaxLabel(num: Int) -> some View {
        
        // 最高気温
        // 小数第2位で四捨五入
        let tempMax = round(model.list[num].main.temp_max * 10) / 10
        // 表示を小数第1位までにする
        let tempMaxStr = String(format: "%.1f", tempMax)
        return Text("最高気温:\(tempMaxStr)度")
    }
    
    /// 最低気温のラベル
    func tempMinLabel(num: Int) -> some View {
        
        // 最低気温
        // 小数第2位で四捨五入
        let tempMin = round(model.list[num].main.temp_min * 10) / 10
        // 表示を小数第1位までにする
        let tempMinStr = String(format: "%.1f", tempMin)
        return Text("最低気温:\(tempMinStr)度")
    }
    
    /// 平均気温のラベル
    func temperatureLabel(num: Int) -> some View {
        
        // 小数第2位で四捨五入
        let temperature = round(model.list[num].main.temp * 10) / 10
        // 表示を小数第1位までにする
        let temperatureStr = String(format: "%.1f", temperature)
        return Text("平均気温:\(temperatureStr)度")
    }
    
    /// 天候の種類のラベル
    func weatherLabel(num: Int) -> some View {
        
        // 天候の種類
        let weather = model.list[num].weather[0].main
        return Text("\(weather)")
    }
    
    /// 天候の説明ラベル
    func weatherDescriptionLabel(num: Int) -> some View {
        
        // 天候の説明
        let description = model.list[num].weather[0].description
        return Text("\(description)")
    }
    
    /// 天候のアイコン
    func weatherIcon(num: Int) -> some View {
        
        // 天候のアイコン種類
        let iconType = model.list[num].weather[0].icon
        return Image("\(iconType)")
    }
    
    /// 日時
    func dateTime(num: Int) -> some View {
        
        let dateTime = model.list[num].dt_txt
        return Text("\(dateTime)")
    }
}
