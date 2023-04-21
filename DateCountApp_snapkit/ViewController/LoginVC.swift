import UIKit
import SwiftUI
import SnapKit
import Firebase

class LoginVC: UIViewController {
    //MARK: - 필요한뷰 create
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
        loginLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 35)
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
        idField.addLeftPadding()
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
        passField.addLeftPadding()
        return passField
    }()
    private lazy var loginButton : UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return loginButton
    }()
    private lazy var signUpButton : UIButton = {
        let signUpButton = UIButton()
        signUpButton.setTitle("create your account", for: .normal)
        signUpButton.setTitleColor(.blue, for: .normal)
        signUpButton.backgroundColor = .orange
        signUpButton.addTarget(self, action: #selector(moveToSignup), for: .touchUpInside)
        signUpButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        signUpButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return signUpButton
    }()
    private lazy var mainVC : UIViewController = {
       let mainVC = MainVC()
        return mainVC
    }()
    private lazy var SignupVC : UIViewController = {
        let signUpVC = SignUpVC()
        return signUpVC
    }()
    
    let loginViewModel : LoginViewModel = LoginViewModel()
    
    //MARK: - lifecycle
    //환경설정할부분 add
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationKeyboard()
        setTapMethod()
        viewSetUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addView()
        setAutoLayout()
    }
    
    //MARK: - method
    //회원가입 페이지 이동
    @objc private func moveToSignup(sender : UIButton){
        self.navigationController?.pushViewController(SignupVC, animated: true)
    }
    //스크롤뷰 Tab할시 수행할 기능.
    @objc private func RunTapMethod(){
        self.view.endEditing(true)
    }
    
    private func showDialog(msg: String){
        let alert = UIAlertController(title: "알림", message: msg, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
   
    //MARK: - loginAction
    @objc private func loginAction(){
        let user : User = User(email: idField.text, password: passField.text)
        loginViewModel.loginAction(user: user){ result in
            switch result{
            case "NoAccount":
                self.showDialog(msg: "아이디 또는 비밀번호를 잘못 입력하였습니다!")
            case "success":
                self.showDialog(msg: "로그인 성공 ㅎ")
                UserDefaults.standard.set(true, forKey: "isLogin")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(self.mainVC)
            default:
                self.showDialog(msg: "아이디 비밀번호를 모두 입력해세요!")
            }
        }
    }
    
    //MARK: - setUI
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
            make.left.equalTo(containerview.snp.left).offset(60)
            make.bottom.equalTo(containerview.snp.bottom)
        }
    }
    private func viewSetUp(){
        self.navigationItem.title = "로그인"
        self.view.backgroundColor = .systemBackground
        
    }
    
}

//MARK: - 키보드 return 누를시, 다음te
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

//MARK: - textfield패딩
// textField에 패딩주기위한 확장
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

//MARK: - Set Notification
extension LoginVC {
    private func setNotificationKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: - keyboard setUp
extension LoginVC {
    //키보드가 보여지면 할 액션
    @objc private func keyboardWillShow(_ notification: Notification) {
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
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
    }
}

//MARK: -ScrollView tab기능 추가를 위한 setUp
extension LoginVC{
    private func setTapMethod(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RunTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
}

   
