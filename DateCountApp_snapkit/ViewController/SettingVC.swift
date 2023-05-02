import SwiftUI
import UIKit
import SnapKit
import FirebaseAuth

class SettingVC: UIViewController {
    
    let settingViewModel = SettingViewModel()
    var dataSource = [SettingSection]()
    
    
    private lazy var loginVC : UINavigationController = {
        let loginvc = UINavigationController(rootViewController: LoginVC())
        return loginvc
    }()
    
    private lazy var tableview : UITableView = {
        let tableview = UITableView(frame: .zero, style: .insetGrouped)
        tableview.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        tableview.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        tableview.register(SupportCell.self, forCellReuseIdentifier: SupportCell.identifier)
        return tableview
    }()
    
    private func setUpSection(){
        //settingSection
        let settingModel = [
            SettingModel(iconImage: UIImage(systemName: "clock"), titleText: "시간설정하기")
        ]
        let settingSection = SettingSection.setting(settingModel)
        
        //reviewSection
        let reviewModel = [
            ReviewModel(iconImage: UIImage(systemName: "envelope"), title: "명언추천하기"),
            ReviewModel(iconImage: UIImage(systemName: "envelope"),title: "문의하기"),
            ReviewModel(iconImage: UIImage(systemName: "square.and.pencil"),title: "리뷰쓰러가기")
        ]
        let reviewSection = SettingSection.review(reviewModel)
        
        //suportSection
        let supportModel = [
            SupportModel(title: "로그아웃"),
            SupportModel(title: "회원탈퇴")
        ]
        let supportSection = SettingSection.support(supportModel)
        
        self.dataSource = [settingSection, reviewSection, supportSection]
        //        self.settingTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSection()
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
    
    func logout() {
        if settingViewModel.onClickLogout() {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
        }

    }

    private func addView(){
        view.addSubview(tableview)
    }
    
    
}

//MARK: - extension Tableview

extension SettingVC : UITableViewDelegate, UITableViewDataSource {
    
    // section의 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    // 각 섹션에 보여질 셀의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource[section] {
        case let .setting(settingModel):
            return settingModel.count
            
        case let .review (reviewModel):
            return reviewModel.count
            
        case let .support(supportModel):
            return supportModel.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.dataSource[indexPath.section] {
            
        case let .setting(settingModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
            let model = settingModel[indexPath.row]
            cell.bind(model: model)

            
            return cell
            
        case let .support(supportModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: SupportCell.identifier, for: indexPath) as! SupportCell
            let model = supportModel[indexPath.row]
            cell.bind(model: model)
            
            return cell
            
        case let .review(reviewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
            let model = reviewModel[indexPath.row]
            cell.bind(model: model)

            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                let pushVC = SetTimeVC()
                pushVC.modalTransitionStyle = .coverVertical
                pushVC.modalPresentationStyle = .automatic
                self.present(pushVC, animated: true, completion: nil)
                return
            }
        case 1:
            if indexPath.row == 0{
                guard let url = URL(string: "mailto:gusgh4922@gmail.com") else{ return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                return
            }
            if indexPath.row == 1{
                guard let url = URL(string: "mailto:gusgh4922@gmail.com") else{ return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                return
            }
            if indexPath.row == 2{
                print("1-2")
                return
            }
        case 2:
            if indexPath.row == 0{
                logout()
                return
            }
            if indexPath.row == 1{
                
                return
            }
            
        default:
            print("suk")
        }
        
    }
    
    
}
