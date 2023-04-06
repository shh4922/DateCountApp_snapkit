import UIKit
import SnapKit

class TabbarVC : UITabBarController {
    
    private lazy var listVC : ListVC = {
        let listVC = ListVC()
        return listVC
    }()
    private lazy var homeVC : HomeVC = {
        let homeVC = HomeVC()
        return homeVC
    }()
    private lazy var settingVC : SettingVC = {
        let settingVC = SettingVC()
        return settingVC
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}
