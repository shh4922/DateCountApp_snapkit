import SwiftUI
import UIKit

class SignUpVC: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel = UILabel()
    private let subLabel = UILabel()
    
    private let IdField = UITextField()
    private let passwordField = UITextField()
    private let Btn_createAccount = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayout()
    }
    
    
    private func setLayout(){
        self.navigationItem.title = "회원가입"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(IdField)
        contentView.addSubview(passwordField)
        contentView.addSubview(IdField)
        contentView.addSubview(passwordField)
        contentView.addSubview(Btn_createAccount)
        
        scrollView.backgroundColor = .white
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        contentView.backgroundColor = .white
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
        
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "오늘의 명언"
        titleLabel.font = .boldSystemFont(ofSize: 40)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).inset(50)
            make.left.equalTo(contentView.snp.left).inset(30)
        }
        subLabel.textAlignment = .center
        subLabel.textColor = .lightGray
        subLabel.text = "하루명언으로 항상 동기부여받으며 공부해요."
        subLabel.font = .systemFont(ofSize: 15)
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(view).inset(30)
        }
        IdField.placeholder = "사용하실아이디를 입력하세요"
        IdField.textColor = .black
        IdField.textAlignment = .center
        IdField.font = .systemFont(ofSize: 23)
        IdField.layer.cornerRadius = 3
        IdField.backgroundColor = UIColor(named: "textFieldColor")
        IdField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel.snp.bottom).offset(70)
            make.left.right.equalTo(view).inset(30)
        }
        passwordField.placeholder = "사용하실 비밀번호를 입력하세요."
        passwordField.textAlignment = .center
        passwordField.textColor = .black
        passwordField.font = .systemFont(ofSize: 23)
        passwordField.layer.cornerRadius = 3
        passwordField.backgroundColor = UIColor(named: "textFieldColor")
        passwordField.isSecureTextEntry = true
        passwordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(IdField.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(30)
        }
        Btn_createAccount.backgroundColor = .systemBlue
        Btn_createAccount.layer.cornerRadius = 5
        Btn_createAccount.setTitle("OK", for: .normal)
        Btn_createAccount.setTitleColor(.blue, for: .normal)
        Btn_createAccount.setTitleColor(.white, for: .normal)
        Btn_createAccount.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(60)
            make.bottom.equalTo(contentView)
        }
    }
    private func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillShow(_ notification : Notification){
        /**
         아직 하단의 코드는 이해하지못했다.
         userInfo가 뭔지 잘 모르겠다...
         지금은 알바가야하니깐 요까지만하고 집가서 다시찾아보고 공부해야겠당
         */
        guard let userInfo = notification.userInfo,let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        //좌표 (0,550) 부터 가로=414, 세로 346 짜리의 키보드다 이말.
        print(keyboardFrame.size.height)
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
        print("sighUpVC - keyboardWillHide run")
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
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
