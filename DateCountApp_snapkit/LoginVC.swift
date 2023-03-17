import UIKit
import SwiftUI
import SnapKit

class LoginVC: UIViewController {
    
    private let containerview = UIView()
    private var idField = UITextField()
    private var passField = UITextField()
    private var loginLabel = UILabel()
    private var subLabel = UILabel()
    private var scrollView = UIScrollView()
    private let loginButton = UIButton()
    private let signUpButton = UIButton()
    
    private var keyHeight = UIView()
    private var nskey = NSLayoutConstraint()
    
    private func setLayout(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        view.addSubview(scrollView)
    
        scrollView.addSubview(containerview)
        scrollView.addSubview(loginLabel)
        scrollView.addSubview(subLabel)
        scrollView.addSubview(idField)
        scrollView.addSubview(passField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(signUpButton)
        scrollView.addSubview(keyHeight)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(0)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-1)
        }
        keyHeight.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(0)
            make.leading.equalTo(scrollView.snp.leading).offset(0)
            make.trailing.equalTo(scrollView.snp.trailing).offset(0)
            make.bottom.equalTo(scrollView.snp.bottom).offset(0)
        }
        containerview.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(0)
            make.leading.equalTo(scrollView.snp.leading).offset(0)
            make.trailing.equalTo(scrollView.snp.trailing).offset(0)
            make.bottom.equalTo(scrollView.snp.bottom).offset(0)
        }
        
        loginLabel.textColor = .black
        loginLabel.textAlignment = .center
        loginLabel.text = "오늘의 명언"
        loginLabel.font = .boldSystemFont(ofSize: 40)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerview.snp.top).offset(20)
            make.leading.equalTo(containerview.snp.leading).offset(30)
        }
        
        subLabel.text = "하루명언으로 항상 동기부여받으며 공부해요."
        subLabel.textAlignment = .center
        subLabel.font = .boldSystemFont(ofSize: 15)
        subLabel.textColor = .lightGray
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(5)
            make.leading.equalTo(containerview.snp.leading).offset(30)
        }
        
        idField.placeholder = "id"
        idField.textColor = .black
        idField.backgroundColor = UIColor(named: "textFieldColor")
        idField.layer.cornerRadius = 4
        idField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel.snp.bottom).offset(30)
            make.leading.equalTo(containerview.snp.leading).offset(40)
        }
        
        passField.placeholder = "password"
        passField.textColor = .black
        passField.backgroundColor = UIColor(named: "textFieldColor")
        passField.layer.cornerRadius = 4
        passField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idField.snp.bottom).offset(10)
            make.leading.equalTo(containerview.snp.leading).offset(40)
        }
        
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passField.snp.bottom).offset(40)
            make.leading.equalTo(containerview.snp.leading).offset(100)
        }
        
        signUpButton.setTitle("create your account", for: .normal)
        signUpButton.setTitleColor(.blue, for: .normal)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(5)
            make.leading.equalTo(containerview.snp.leading).offset(20)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardObserver()
    }
    
    
    private func addKeyboardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
}




extension UIViewController {

    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    

    
    @objc func keyboardWillShow(_ sender: Notification) {
        
            let userInfo:NSDictionary = sender.userInfo! as NSDictionary
            let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
//            keyHeight = keyboardHeight
        print("keyboard run")
            self.view.frame.size.height -= keyboardHeight
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        
        self.view.frame.size.height += Keybo
        if let height = keyHeight {
            self.view.frame.size.height += height
        }
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
