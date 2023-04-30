import SwiftUI
import UIKit
import SnapKit
import FirebaseAuth

class SettingVC: UIViewController {
    
    let settingViewModel = SettingViewModel()
    let sections = ["first","seccond","third"]
    let items = [
        ["1-one","1-two","1-three"],
        ["2-one","2-two","2-three"],
        ["3-one","3-two","3-three"]
    ]
    private lazy var tableview : UITableView = {
        let tableview = UITableView(frame: .zero, style: .insetGrouped)
        tableview.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        return tableview
    }()
    
    private lazy var loginVC : UINavigationController = {
        let loginvc = UINavigationController(rootViewController: LoginVC())
        return loginvc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addView()
        setLayout()
        
        
    }
    private func setUp(){
        self.navigationItem.title = "설정"
        view.backgroundColor = .white
        
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    private func setLayout(){
        tableview.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    private func addView(){
        view.addSubview(tableview)
    }
    
    
}
extension SettingVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier) as? SettingCell ?? SettingCell()
        cell.label.text = items[indexPath.section][indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
}


//
//@objc func logout() {
//    if settingViewModel.onClickLogout() {
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
//    }else{
//        //실패알림
//    }
//
//}
