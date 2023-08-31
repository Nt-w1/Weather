//
//  OpenWeatherInfo.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/21.
//

import Foundation

/// OpenWeatherAPIから取得した情報を扱うクラス
class OpenWeatherInfo {
    
    private var BASE_URL = "https://api.openweathermap.org/data/2.5/forecast"
    
    /// openWeatherAPIから天気情報を取得する
    func fetchOpenWeatherInfo(region: DefaultRegion = .tokyo, latAndLon: [Int] = [0], searchType: SearchType, completion: @escaping (OpenWeatherModel) -> Void) {
        
        // APIKEYを取得plistから取得する
        guard let API_KEY = PropertyListManager.shared.getOpenWeatherAPIkey() else {
            
            return
        }
        
        // 検索タイプによってクエリを選択する
        var query: String
        switch searchType {
            
        case .region:
            query = "?q=\(region.rawValue)&APPID=\(API_KEY)&units=metric&lang=ja"
            
        case .latAndLon:
            query = "?lat=\(latAndLon[0])&lon=\(latAndLon[1])&APPID=\(API_KEY)&units=metric&lang=ja"
            
        }
        
        // APIコール
        openWeatherAPIRequest(query: query, completion: completion)
    }
    
    /// 地域名を指定してopenWeatherAPIから天気情報を取得する
    /// - Parameters:
    ///   - regionNmae: 地域名
    ///   - completion: 取得後のクロージャ
    func fetchOpenWeatherInfoByRegionName(regionName: String, completion: @escaping (OpenWeatherModel) -> Void) {
        
        // APIKEYを取得plistから取得する
        guard let API_KEY = PropertyListManager.shared.getOpenWeatherAPIkey() else {
            
            return
        }
        
        // 指定された地域名でクエリを作成
        let query: String = "?q=\(regionName)&APPID=\(API_KEY)&units=metric&lang=ja"
        
        // APIコール
        openWeatherAPIRequest(query: query, completion: completion)
    }
    
    /// 緯度経度を指定してopenWeatherAPIから天気情報を取得する
    /// - Parameters:
    ///   - latAndLon: 緯度経度
    ///   - completion: 取得後のクロージャ
    func fetchOpenWeatherInfoByLatAndLon(latAndLon: [Int], completion: @escaping (OpenWeatherModel) -> Void) {
        
        // APIKEYを取得plistから取得する
        guard let API_KEY = PropertyListManager.shared.getOpenWeatherAPIkey() else {
            
            return
        }
        
        // 指定された地域名でクエリを作成
        let query: String = "?lat=\(latAndLon[0])&lon=\(latAndLon[1])&APPID=\(API_KEY)&units=metric&lang=ja"
        
        // APIコール
        openWeatherAPIRequest(query: query, completion: completion)
    }
    
    /// openWeatherAPIから天気情報を取得する
    /// - Parameters:
    ///   - query: クエリ
    ///   - completion: API取得後の処理
    private func openWeatherAPIRequest(query:String, completion: @escaping (OpenWeatherModel) -> Void) {
        
        // 指定されたクエリでURLRequestを行う
        guard let url = URL(string: BASE_URL + query) else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let task = URLSession.shared.dataTask(with: request) {data,response,error in
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                // データをデコード(jsonから画面に表示できるよう加工。)
                // .decodeメソッドには、型名とデコードするData型を指定。
                let decoded = try decoder.decode(OpenWeatherModel.self, from: data)
                completion(decoded)
            } catch {
                
                print("\(error)")
            }
        }
        task.resume()
    }
    
    /// openWeatherAPIから取得した天気情報をUserDefaultsに保存する
    /// - Parameters:
    ///   - model: 取得した天気情報
    ///   - type: 取得した天気情報の地域
    func saveOpenWeatherInfo(model: OpenWeatherModel, type: String) {
        
        // 構造体はUDに保存できないのでデータ型に変換
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(model) else {
            
            return
        }
        UserDefaults.standard.set(data, forKey: type)
    }
    
    
    /// 保存した天気情報を返す
    /// - Parameter type: 表示する地域
    /// - Returns: 表示する地域の天気情報
    func getOpenWeatherInfo(type: DefaultRegion) -> OpenWeatherModel {
        
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: type.rawValue),
              let model = try? decoder.decode(OpenWeatherModel.self, from: data) else {
            
            // 読み込みやデコードに失敗した場合はからのOpenWeatherModelを返す
            return OpenWeatherModel(list: [WeatherList(dt: 0, main: MainInfo(temp: 0.0, temp_min: 0.0, temp_max: 0.0), weather: [Weather(main: "", description: "", icon: "")], dt_txt: "")], city: City(name: ""))
        }
        
        return model
    }
    
    /// 保存した東京,兵庫,大分,札幌の天気情報を取得する
    func getAllOpenWeatherInfo() -> [OpenWeatherModel] {
        
        var model: [OpenWeatherModel] = []
        
        DefaultRegion.allCases.forEach { region in
            
            model.append(getOpenWeatherInfo(type: region))
        }
        
        return model
    }
}

/// openWeatherAPIの検索タイプ
enum SearchType {
    
    ///地域名
    case region
    ///緯度経度
    case latAndLon
}
