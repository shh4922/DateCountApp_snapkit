import SwiftUI
import UIKit
import SnapKit
import Firebase
//asdasd
class SignUpVC: UIViewController {
    
    let signUpViewModel : SignUpViewModel = SignUpViewModel()
    //MARK: - viewCreate
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    private lazy var contentView : UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "오늘의 명언"
        titleLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 40)
        return titleLabel
    }()
    private lazy var subLabel : UILabel = {
        let subLabel = UILabel()
        subLabel.textAlignment = .center
        subLabel.textColor = .lightGray
        subLabel.text = "하루명언으로 항상 동기부여받으며 공부해요."
        subLabel.font = .systemFont(ofSize: 15)
        return subLabel
    }()
    private lazy var IdField : UITextField = {
        let IdField = UITextField()
        IdField.placeholder = "사용하실아이디를 입력하세요"
        IdField.delegate = self
        IdField.textColor = .black
        IdField.textAlignment = .center
        IdField.font = .systemFont(ofSize: 23)
        IdField.layer.cornerRadius = 3
        IdField.backgroundColor = UIColor(named: "textFieldColor")
        IdField.addLeftPadding()
        return IdField
    }()
    private lazy var passwordField : UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "사용하실 비밀번호를 입력하세요."
        passwordField.delegate = self
        passwordField.textAlignment = .center
        passwordField.textColor = .black
        passwordField.font = .systemFont(ofSize: 23)
        passwordField.layer.cornerRadius = 3
        passwordField.backgroundColor = UIColor(named: "textFieldColor")
        passwordField.isSecureTextEntry = true
        passwordField.addLeftPadding()
        return passwordField
    }()
    private lazy var Btn_createAccount : UIButton = {
        let Btn_createAccount = UIButton()
        Btn_createAccount.backgroundColor = .systemBlue
        Btn_createAccount.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        Btn_createAccount.layer.cornerRadius = 5
        Btn_createAccount.setTitle("OK", for: .normal)
        Btn_createAccount.setTitleColor(.blue, for: .normal)
        Btn_createAccount.setTitleColor(.white, for: .normal)
        return Btn_createAccount
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setNotification()
        setTapMethod()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addView()
        setAutoLayout()
    }
    
    //MARK: - setUpView
    private func addView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(IdField)
        contentView.addSubview(passwordField)
        contentView.addSubview(IdField)
        contentView.addSubview(passwordField)
        contentView.addSubview(Btn_createAccount)

    }
    private func setAutoLayout(){
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).inset(50)
            make.left.equalTo(contentView.snp.left).inset(30)
        }
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(view).inset(30)
        }
        
        IdField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel.snp.bottom).offset(70)
            make.left.right.equalTo(view).inset(30)
        }
        
        passwordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(IdField.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(30)
        }

        Btn_createAccount.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(60)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    private func setUpView(){
        self.navigationItem.title = "회원가입"
        view.backgroundColor = .white
        
    }
    
    
    
    //MARK: - method
    @objc private func RunTapMethod(){
        self.view.endEditing(true)
    }
    
    private func showDialog(msg: String){
        let alert = UIAlertController(title: "알림", message: msg, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @objc private func signUpAction(){
        let user = User(email: IdField.text, password: passwordField.text)
        signUpViewModel.signUpAction(userData: user) { result in
            switch result{
            case "success":
                self.showDialog(msg: "성공")
            case "SameAccount":
                self.showDialog(msg: "중복된 계정이 있습니다!")
            default :
                self.showDialog(msg: "아이디와 비밀번호를 모두 입력해주세요!")
            }
        }
    }
    
}

//MARK: - 리턴누를시 다음 textField로 이동하는기능
extension SignUpVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == IdField {
        print("id - return")
      passwordField.becomeFirstResponder()
    } else {
        print("password - return")
      passwordField.resignFirstResponder()
    }
    return true
  }
}

//MARK: - 키보드 notification setUp
extension SignUpVC {
    private func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(_ notification : Notification){
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
    @objc private func keyboardWillHide(){
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset

    }
}

//MARK: - ScrollView Tab Action setUp
extension SignUpVC {
    private func setTapMethod(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RunTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
}
