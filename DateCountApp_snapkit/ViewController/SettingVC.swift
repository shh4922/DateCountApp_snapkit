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
    
    //MARK: - 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSection()
        setupNotification()
        setUp()
        addView()
        setLayout()
    }
    
    //MARK: - 기본설정
    private func setUpSection(){
        //settingSection
        let settingModel = [
            SettingModel(iconImage: UIImage(systemName: "clock"), titleText: "시간설정하기")
        ]
        let settingSection = SettingSection.setting(settingModel)
        
        //reviewSection
        let reviewModel = [
            ReviewModel(iconImage: UIImage(systemName: "envelope"), title: "명언추천하기"),
            ReviewModel(iconImage: UIImage(systemName: "envelope"),title: "문의하기")
        ]
        let reviewSection = SettingSection.review(reviewModel)
        
        //suportSection
        let supportModel = [
            SupportModel(title: "로그아웃"),
            SupportModel(title: "회원탈퇴")
        ]
        let supportSection = SettingSection.support(supportModel)
        
        self.dataSource = [settingSection, reviewSection, supportSection]
    }
    private func setUp(){
        self.navigationItem.title = "설정"
        view.backgroundColor = .white
        tableview.dataSource = self
        tableview.delegate = self
    }
    private func addView(){
        view.addSubview(tableview)
    }
    private func setLayout(){
        tableview.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: - UI변경
    private func showDialog(msg: String){
        let alert = UIAlertController(title: "알림", message: msg, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    @objc private func showDialog2(){
        let alert = UIAlertController(title: "알림!", message: "시간이 재설정되었습니다!\n앱을 백그라운드에서 종료후 다시시작해주세요!!", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    private func moveToViewController(view : UIViewController){
        view.modalTransitionStyle = .coverVertical
        view.modalPresentationStyle = .automatic
        self.present(view, animated: true, completion: nil)
    }
    
    //MARK: - 기능
    private func deleteAlter(){
        // 메시지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "알림", message: "회원탈퇴시, 기존의 모든데이터가 삭제됩니다", preferredStyle: UIAlertController.Style.alert)

        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let cancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        let delete = UIAlertAction(title: "삭제", style: UIAlertAction.Style.destructive){(_) in
            if self.settingViewModel.deleteAccount() {
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(self.loginVC)
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            }else{
                self.showDialog(msg: "오류가발생했습니다. 로그아웃후 다시 시도해주세요")
            }
        }

        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(cancel)
        alert.addAction(delete)

        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: false)
    }
    private func logoutAlter(){
        // 메시지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "알림", message: "비회원으로 사용시, 기존데이터를 되돌릴수없습니다. 로그아웃하시겠습니까?", preferredStyle: UIAlertController.Style.alert)

        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let cancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        let delete = UIAlertAction(title: "로그아웃", style: UIAlertAction.Style.destructive){(_) in
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(self.loginVC)
            self.settingViewModel.onClickLogout()
            
        }

        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(cancel)
        alert.addAction(delete)

        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: false)
    }
}

//MARK: - extension Tableview
extension SettingVC : UITableViewDelegate, UITableViewDataSource {
    
    // 섹션의 개수 리턴
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    // 센션에 있는 셀의개수 리턴
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
    
    // 섹션의 어떤셀을 보여줄지 경정하는곳
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
    
    //각 섹션의 셀을 호출시, 수행할 기능.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                moveToViewController(view: SetTimeVC())
                return
            }
        case 1:
            if indexPath.row == 0{
                settingViewModel.sendEmail()
                return
            }
            if indexPath.row == 1{
                settingViewModel.sendEmail()
                return
            }
        case 2:
            if indexPath.row == 0 {
                logoutAlter()
                return
            }
            if indexPath.row == 1 {
                deleteAlter()
                return
            }
            
        default:
            showDialog(msg: "잘못된 입력입니다.")
        }
        
    }
    
    
}

extension SettingVC {
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(showDialog2), name: Notification.Name("changeTime"), object: nil)
    }
}
