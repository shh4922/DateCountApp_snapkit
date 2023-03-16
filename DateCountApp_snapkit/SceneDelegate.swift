//
//  SceneDelegate.swift
//  DateCountApp_snapkit
//
//  Created by HyeonHo on 2023/03/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //그려질 화면? 앱? 폰?
        window = UIWindow(windowScene: windowScene)
        
        //시작 화면
        let rootViewController = LoginVC()
        //rootView(LoginViewController)에 navigationController 추가
        let navigationController = UINavigationController(rootViewController: rootViewController)
        //시작화면은 추가된 NavViewController로 저장
        self.window?.rootViewController = navigationController
        
        // Not nil이면  화면그려!
        window?.makeKeyAndVisible()
    }
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}

}

