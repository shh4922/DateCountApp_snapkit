import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let mainVC = TabbarVC()
    let loginVC = LoginVC()
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        //그려질 화면? 앱? 폰?
        window = UIWindow(windowScene: windowScene)
        
        
        // if user is logged in before
        if let loggedUsername = UserDefaults.standard.string(forKey: "userName") {
            
            window?.rootViewController = mainVC
        } else {
            
            window?.rootViewController = loginVC
        }
        //시작 화면

//        window?.rootViewController = loginVC
//        let navigationController = UINavigationController(rootViewController: loginVC)
//        self.window?.rootViewController = navigationController
        
        // Not nil이면  화면그려!
        window?.makeKeyAndVisible()
        
        
    }
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        // change the root view controller to your specific view controller
        window.rootViewController = vc
    }

}

