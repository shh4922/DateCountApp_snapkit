import SwiftUI
import UIKit
import SnapKit
import Firebase

class SettingVC: UIViewController {
    
    private lazy var logoutButton : UIButton = {
        let myButton = UIButton()
        myButton.addTarget(self,action: #selector(logout),for: .touchUpInside)
        myButton.backgroundColor = .systemBlue
        myButton.setTitle("logout", for: .normal)
        myButton.tintColor = .white
        return myButton
    }()
    private lazy var loginVC : UINavigationController = {
        let loginvc = UINavigationController(rootViewController: LoginVC())
        return loginvc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addView()
        setLayout()
        self.navigationItem.title = "테스트임"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(test))
        
    }
    @objc private func test(){
        print("onclick")
    }
    private func setLayout(){
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
    }
    private func addView(){
        view.addSubview(logoutButton)
    }
    
    @objc func logout(){
        let auth = Auth.auth()
        print("logout!!")
        do {
            try auth.signOut()
            UserDefaults.standard.set(false, forKey: "isLogin")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
        }catch let signOutError {
            print("로그아웃에러!!!!!!!!!!!!!@@@@@@@@@@@@@@@@!!@!@!@!@")
            print(signOutError)
        }
        
    }
}


#if DEBUG
struct settingVC : UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
        
    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        SettingVC()
    }
}
@available(iOS 13.0, *)
struct SettingVC_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            settingVC()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif

