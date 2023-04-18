import UIKit
import SnapKit

class MainVC : UITabBarController {
    
    private lazy var listVC : UIViewController = {
        let listVC = ListVC()
        return listVC
    }()
    private lazy var homeVC : UIViewController = {
        let homeVC = HomeVC()
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
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .systemBlue
        self.tabBar.itemPositioning = .centered
//        self.tabBar.layer.cornerRadius = 10
        self.tabBar.unselectedItemTintColor = .lightGray
        
        homeVC.title = "home"
        listVC.title = "list"
        settingVC.title = "setting"
        self.setViewControllers([listVC,homeVC,settingVC], animated: false)
        
        guard let items = self.tabBar.items else {
            return
        }
        let images = ["list.bullet","house.fill","gearshape.fill"]
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}

