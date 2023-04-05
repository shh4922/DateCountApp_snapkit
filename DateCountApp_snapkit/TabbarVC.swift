import UIKit
import SnapKit

class TabbarVC : UITabBarController {
    
    //명언을 보여줄 뷰
    let listVC = ListVC()
    //사용자의 시험일정을 보여줄 뷰
    let homeVC = HomeVC()
    //사용자의 설정을 컨트롤할 뷰
    let settingVC = SettingVC()
    
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
