//
//  SceneDelegate.swift
//  Weathers
//
//  Created by 永瀬 on 2023/08/29.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let rootView = HomeView()
        
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
