import SwiftUI
import UIKit
import SnapKit
import Firebase

class SignUpVC: UIViewController {

    private var ref : DatabaseReference!
    let db = Firestore.firestore()
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
        self.navigationItem.title = "회원가입"
        view.backgroundColor = .white
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            //세로 스크롤이 가능하도록 하기위해 width는 화면의view와 크기를 맞춤
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
    
    //MARK: - setUp
    //스크롤뷰에 tab기능 추가를 위한 설정
    private func setTapMethod(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RunTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    private func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - action
    //스크롤뷰 Tab할시 수행할 기능.
    @objc private func RunTapMethod(){
        self.view.endEditing(true)
    }
    //가입완료 누를시.
    @objc private func signUpAction(){
        if let email = IdField.text , let password = passwordField.text{
            Auth.auth().createUser(withEmail: email, password: password){ (user,error) in
                if user != nil{
                    print("가입성공")
                    let userInfo : TestData = TestData(email: email, password: password)
                    guard let uid = user?.user.uid else { return }
                    self.ref = Database.database().reference()
                    self.ref.child("Users").child(uid).child("info").setValue([
                        "email" : email,
                        "password" : password,
                        "deleveredData" : [
                            "A" :[
                                "text" : "aaa",
                                "author" : "bbb"
                            ]
                        ],
                        "subscribedData" : nil
                    ])
                }else{
                    print("가입 실패!")
                }
            }
        }
    }
    
    //MARK: - 키보드 셋업
    //키보드가 보여질시 스크롤이 가능하도록 하기위해서 contentInset 조정
    @objc private func keyboardWillShow(_ notification : Notification){
        print("signUpVC keyboardWillShow()-run")
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
    //키보드가 사라질시 contentInset.zero
    @objc private func keyboardWillHide(){
        print("signUpVC keyboardWillHide()-run")
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset

    }
    
}

//MARK: - 리턴누를시 다음 textField로 이동하는기능
//키보드 return버튼 클릭시, 다음input으로 이동을 위해 Delegate추가.
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



#if DEBUG
struct SignupView: UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){

    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        SignUpVC()
    }
}
@available(iOS 13.0, *)
struct SignupView_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            SignupView()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif
