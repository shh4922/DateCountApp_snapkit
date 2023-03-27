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
            //스크롤뷰 상하좌우 모두 세이프에어리어에 맞추기.
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerview.snp.makeConstraints { make in
            //상하좌우를 모두 scrollview에 일단은 맞춤
            make.top.bottom.left.right.equalTo(scrollView)
            //좌우는 scrollview와 같게 해야 상.하 로만 스크롤이 가능하기때문에 넓이는 scrollview와 같게맞춤
            make.width.equalTo(scrollView.snp.width)
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
        idField.textContentType = .emailAddress
        idField.keyboardType = .emailAddress
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
        passField.textContentType = .password
        passField.keyboardType = .default
        passField.isSecureTextEntry = true
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationKeyboard()
        setLayout()
    }
    
    
    
    //회원가입 페이지 이동
    @objc private func moveToSignup(sender : UIButton){
        let signUpVC = SignUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
    //SetNotificationObserver
    private func setNotificationKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    //키보드가 보여지면 할 액션
    @objc private func keyboardWillShow(_ notification: Notification) {
        print("loginVC keyboardWillShow()-run")
    }
    
    
    //키보드가 뷰에서 안보이면 하는 액션
    @objc private func keyboardWillHide() {
        print("loginVC keyboardWillHide()-run")
    }
    
}

   




//프리뷰
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

