import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var mainVC : MainVC = {
        let mainVC = MainVC()
        return mainVC
        
    }()
    private lazy var loginVC : UINavigationController = {
        let loginVC = LoginVC()
        let navLoginVC = UINavigationController(rootViewController: loginVC)
        return navLoginVC
    }()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        //그려질 화면? 앱? 폰?
        window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "isLogin"){
            print("is login true")
            print("SceneDelegate_ \(Auth.auth().currentUser?.email)")
            window?.rootViewController = mainVC
        }else{
            print("is login false")
            window?.rootViewController = loginVC
        }
        
        // 화면그려!
        window?.makeKeyAndVisible()
        
        
    }
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    // rootView바꿔주는 코드!
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        window.rootViewController = vc
        // add animation
           UIView.transition(with: window,
                             duration: 0.5,
                             options: [.transitionFlipFromLeft],
                             animations: nil,
                             completion: nil)
        
    }

}

