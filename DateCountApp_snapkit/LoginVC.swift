import UIKit
import SwiftUI
import SnapKit
import Firebase

class LoginVC: UIViewController {
    
    var isLogin : Bool = false
    
    private lazy var containerview : UIView = {
        let containerview = UIView()
        containerview.backgroundColor = .systemBackground
        return containerview
    }()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    private lazy var loginLabel : UILabel = {
        let loginLabel = UILabel()
        loginLabel.textColor = .black
        loginLabel.textAlignment = .center
        loginLabel.text = "오늘의 명언"
        loginLabel.font = .boldSystemFont(ofSize: 40)
        return loginLabel
    }()
    private lazy var subLabel : UILabel = {
        let subLabel = UILabel()
        subLabel.text = "하루명언으로 항상 동기부여받으며 공부해요."
        subLabel.textAlignment = .center
        subLabel.font = .boldSystemFont(ofSize: 15)
        subLabel.textColor = .lightGray
        return subLabel
    }()
    private lazy var idField : UITextField = {
        let idField = UITextField()
        idField.placeholder = "id"
        idField.delegate = self
        idField.textContentType = .emailAddress
        idField.keyboardType = .emailAddress
        idField.textColor = .black
        idField.backgroundColor = UIColor(named: "textFieldColor")
        idField.layer.cornerRadius = 4
        return idField
    }()
    private lazy var passField : UITextField = {
        let passField = UITextField()
        passField.placeholder = "password"
        passField.delegate = self
        passField.textColor = .black
        passField.backgroundColor = UIColor(named: "textFieldColor")
        passField.layer.cornerRadius = 4
        passField.textContentType = .password
        passField.keyboardType = .default
        passField.isSecureTextEntry = true
        return passField
    }()
    private lazy var loginButton : UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return loginButton
    }()
    private lazy var signUpButton : UIButton = {
        let signUpButton = UIButton()
        signUpButton.setTitle("create your account", for: .normal)
        signUpButton.setTitleColor(.blue, for: .normal)
        signUpButton.backgroundColor = .orange
        signUpButton.addTarget(self, action: #selector(moveToSignup), for: .touchUpInside)
        return signUpButton
    }()
    private lazy var mainVC : UIViewController = {
       let mainVC = TabbarVC()
        return mainVC
    }()
    private lazy var SignupVC : UIViewController = {
        let signUpVC = SignUpVC()
        return signUpVC
    }()
    var currentUser : UserModel? = nil
    private func addView(){
        view.addSubview(scrollView)
        scrollView.addSubview(containerview)
        containerview.addSubview(loginLabel)
        containerview.addSubview(subLabel)
        containerview.addSubview(idField)
        containerview.addSubview(passField)
        containerview.addSubview(loginButton)
        containerview.addSubview(signUpButton)
    }
    private func setAutoLayout(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        containerview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerview.snp.top).offset(50)
            make.left.equalTo(containerview.snp.left).offset(30)
        }
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(5)
            make.left.equalTo(containerview.snp.left).offset(30)
        }
        idField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel.snp.bottom).offset(30)
            make.left.equalTo(containerview.snp.left).offset(40)
            make.height.equalTo(50)
        }
        passField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idField.snp.bottom).offset(10)
            make.left.equalTo(containerview.snp.left).offset(40)
            make.height.equalTo(50)
        }
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passField.snp.bottom).offset(40)
            make.left.equalTo(containerview.snp.left).offset(100)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(50)
            make.left.equalTo(containerview.snp.left).offset(50)
            make.bottom.equalTo(containerview.snp.bottom)
        }
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationKeyboard()
        setTapMethod()
        
        if let person = Auth.auth().currentUser{
            print("이미 로그인하셧습니다. 그 로그인한 계정은 \(person)")
            
            UserDefaults.standard.string(forKey: "userName")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(self.mainVC)
//            self.navigationController?.pushViewController(mainVC, animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "로그인"
        self.view.backgroundColor = .systemBackground
        
        //기본 설정들.
        addView()
        setAutoLayout()
    }
    
    //회원가입 페이지 이동
    @objc private func moveToSignup(sender : UIButton){
        self.navigationController?.pushViewController(SignupVC, animated: true)
    }
    
    //스크롤뷰 Tab할시 수행할 기능.
    @objc private func RunTapMethod(){
        self.view.endEditing(true)
    }
    //키보드가 보여지면 할 액션
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        print("loginVC keyboardWillShow()-run")
        
        //키보드가 올라오면
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
    //키보드가 뷰에서 안보이면 하는 액션
    @objc private func keyboardWillHide() {
        print("loginVC keyboardWillHide()-run")
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
    }
    //로그인 버튼 클릭
    @objc private func loginAction(){
        //아이디 패스워드 비어있는값
        if let email = idField.text, let password = passField.text{
            Auth.auth().signIn(withEmail: email, password: password){ authResult,error in
                if email == "" || password == ""{
                    print("아이디또는 비밀번호를 모두 입력하시오 ")
                    return
                }
                if let e = error{
                    print("아이디 비번은 입력되었지만, error가 난 경우")
                    print("email : \(email), password : \(password)")
                    print(e.localizedDescription)
                }else{
                    print("email : \(email), password : \(password)")
                    print("login Succes")
                    UserDefaults.standard.string(forKey: "userName")
//                    var appDelegate = UIApplication.shared.delegate as! SceneDelegate
//                    appDelegate.window?.rootViewController = self.mainVC
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(self.mainVC)
                    
//                    self.navigationController?.pushViewController(self.mainVC, animated: true)
                }
            }
        }
    }
    
    
    
    //스크롤뷰에 tab기능 추가를 위한 설정
    private func setTapMethod(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RunTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    //Set Notification
    private func setNotificationKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //Set Layout
  
    
}

//keyboard에서 return 누를시, 다음 input으로 넘어가게 하기위해서 UITextFieldDelegate 추가
extension LoginVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == idField {
        print("id - return")
      passField.becomeFirstResponder()
    } else {
        print("password - return")
      passField.resignFirstResponder()
    }
    return true
  }
}

   
//
////프리뷰
//#if DEBUG
//    struct ViewControllerRepresentable: UIViewControllerRepresentable {
//        // update
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context){
//
//        }
//        // makeui
//        @available(iOS 13.0, *)
//        func makeUIViewController(context: Context) -> UIViewController {
//            LoginVC()
//        }
//    }
//    @available(iOS 13.0, *)
//    struct ViewController_Previews: PreviewProvider {
//        static var previews: some View{
//            Group{
//                ViewControllerRepresentable()
//                    .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
//                    .previewDisplayName("iphone 11")
//            }
//        }
//    }
//
//#endif

