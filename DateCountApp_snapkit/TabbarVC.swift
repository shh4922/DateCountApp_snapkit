import UIKit
import SnapKit

class TabbarVC : UITabBarController {
    
    let homeVC = HomeVC()
    let listVC = ListVC()
    let settingVC = SettingVC()
    
    private func setTabBar(){
        homeVC.title = "home"
        listVC.title = "list"
        settingVC.title = "setting"
        self.setViewControllers([homeVC,listVC,settingVC], animated: false)
        self.tabBar.backgroundColor = .white
        guard let items = self.tabBar.items else { return }
        
        let images = ["house.fill","list.bullet","gearshape.fill"]
        
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
