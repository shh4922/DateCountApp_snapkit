import UIKit
import SnapKit

class MainVC : UITabBarController {
    
    private lazy var listVC : UINavigationController = {
        let listVC = ListVC()
        let navListVC = UINavigationController(rootViewController: listVC)
        return navListVC
    }()
    private lazy var homeVC : UIViewController = {
        let homeVC = HomeVC()
//        let navHomeVC = UINavigationController(rootViewController: homeVC)
//        navHomeVC.navigationBar = "ㄴㅇ"
        return homeVC
    }()
    private lazy var settingVC : SettingVC = {
        let settingVC = SettingVC()
        return settingVC
    }()
    private lazy var logoutButotn : UIButton = {
        let logoutButton = UIButton()
        logoutButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        return logoutButton
    }()


    
    private func setTabBar(){
        homeVC.title = "home"
        listVC.title = "list"
        settingVC.title = "setting"
        self.setViewControllers([listVC,homeVC,settingVC], animated: false)
        self.tabBar.backgroundColor = .white
        guard let items = self.tabBar.items else {
            return
        }
        
        let images = ["list.bullet","house.fill","gearshape.fill"]
        
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
        }
        self.tabBar.tintColor = .systemBlue
        self.tabBar.itemPositioning = .centered
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}

