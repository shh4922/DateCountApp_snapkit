import SwiftUI
import UIKit
import SnapKit

class MainVC : UITabBarController {
    
    private lazy var homeVC : UIViewController = {
        let homeVC = HomeVC()
        return homeVC
    }()
    private lazy var listVC : UIViewController = {
        let listVC = ListVC()
        return listVC
    }()
    private lazy var allQuoteVC : UIViewController = {
        let allQuoteVC = AllQuoteVC()
        return allQuoteVC
    }()
    private lazy var settingVC : UINavigationController = {
        let settingVC = UINavigationController(rootViewController: SettingVC())
        return settingVC
    }()
    private lazy var logoutButotn : UIButton = {
        let logoutButton = UIButton()
        logoutButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        return logoutButton
    }()

    private func setUp(){
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 5
        
        
        homeVC.title = "home"
        listVC.title = "list"
        allQuoteVC.title = "quote"
        settingVC.title = "setting"
        self.setViewControllers([homeVC,listVC,allQuoteVC,settingVC], animated: false)
        
        guard let items = self.tabBar.items else {
            return
        }
        let images = ["house.fill","list.bullet","text.book.closed","gearshape.fill"]
        for x in 0...3 {
            items[x].image = UIImage(systemName: images[x])

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

#if DEBUG
struct mainVC : UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
        
    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        MainVC()
    }
}
@available(iOS 13.0, *)
struct mainVC_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            mainVC()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif
