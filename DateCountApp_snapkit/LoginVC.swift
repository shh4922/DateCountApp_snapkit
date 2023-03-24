import UIKit
import SwiftUI
import SnapKit

class LoginVC: UIViewController {
    
    private let containerview = UIView()
    private var idField = UITextField()
    private var passField = UITextField()
    private var loginLabel = UILabel()
    private var subLabel = UILabel()
    private let loginButton = UIButton()
    private let signUpButton = UIButton()
    private var scrollView = UIScrollView()
    
    private func setLayout(){
        //라지 타이틀 추가
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        
//        self.navigationController?.topViewController?.title = "로그인"
        self.navigationItem.title = "로그인"
        self.view.backgroundColor = .white
        view.addSubview(scrollView)
    
        scrollView.addSubview(containerview)
        containerview.addSubview(loginLabel)
        containerview.addSubview(subLabel)
        containerview.addSubview(idField)
        containerview.addSubview(passField)
        containerview.addSubview(loginButton)
        containerview.addSubview(signUpButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        containerview.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
        
        loginLabel.textColor = .black
        loginLabel.textAlignment = .center
        loginLabel.text = "오늘의 명언"
        loginLabel.font = .boldSystemFont(ofSize: 40)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerview.snp.top).inset(50)
            make.left.equalTo(containerview.snp.left).inset(30)
        }
        
        subLabel.text = "하루명언으로 항상 동기부여받으며 공부해요."
        subLabel.textAlignment = .center
        subLabel.font = .boldSystemFont(ofSize: 15)
        subLabel.textColor = .lightGray
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(5)
            make.left.equalTo(containerview.snp.left).offset(30)
        }
        
        idField.placeholder = "id"
        idField.textColor = .black
        idField.backgroundColor = UIColor(named: "textFieldColor")
        idField.layer.cornerRadius = 4
        idField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel.snp.bottom).offset(30)
            make.left.equalTo(containerview.snp.left).offset(40)
        }
        
        passField.placeholder = "password"
        passField.textColor = .black
        passField.backgroundColor = UIColor(named: "textFieldColor")
        passField.layer.cornerRadius = 4
        passField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idField.snp.bottom).offset(10)
            make.left.equalTo(containerview.snp.left).offset(40)
        }
        
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passField.snp.bottom).offset(40)
            make.left.equalTo(containerview.snp.left).offset(100)
        }
        
        signUpButton.setTitle("create your account", for: .normal)
        signUpButton.setTitleColor(.blue, for: .normal)
        signUpButton.addTarget(self, action: #selector(moveToSignup), for: .touchUpInside)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(40)
            make.left.equalTo(containerview.snp.left).offset(20)
            make.bottom.equalTo(containerview).offset(0)
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNotificationKeyboard()
        setLayout()
    }
    @objc private func moveToSignup(sender : UIButton){
        let signUpVC = SignUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
    private func setNotificationKeyboard(){
        
        /**
         노티피케이션은 수신자는 addObserver, 발신자는 post를 이용해서 이벤트를 감지하는것 같다.
         하지만 내가사용해야하는것은 UIResponder에서 기본적으로 제공하는 keyboardwillshownotification 이랑 keyboardWillHideNotification 이라서
         따로 post를 등록안해도 이미 다 등록이 되어있다
         그냥 수신할곳만 등록을 해주면 된다.
         그래서 아래와 같이 등록을해주었고, 어떤함수가 호출될때 수행하는지 #selector를 선정해주었다.
         */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    /**
     원래는 노티피케이션을 등록시에는 메모리관리를 위해 아래와같이 해제를해주어야하는데
     ios11 부터였나? 해제안햐줘도 알아서 해준다함. 개편힘..
     */
    
//    override func viewWillDisappear(_ animated: Bool) {
//        //노티피케이션 메모리 올라간것 해제.
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
    
    
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        /**
         아직 하단의 코드는 이해하지못했다.
         userInfo가 뭔지 잘 모르겠다...
         지금은 알바가야하니깐 요까지만하고 집가서 다시찾아보고 공부해야겠당
         */
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        
        
        
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
}




 



#if DEBUG
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){

    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        LoginVC()
    }
}
@available(iOS 13.0, *)
struct ViewController_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            ViewControllerRepresentable()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif
