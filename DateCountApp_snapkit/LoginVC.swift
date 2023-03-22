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
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    //현재뷰(자신) 에게 노티피케이션 할당.
    //그떄 호출할 함수는 keyboardWillShow
    //이 노티피케이션의 이름은 ...? 이건뭐지....
    private func setNotificationKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //노티피케이션 메모리 올라간것 해제.
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        //이 아래코드가 뭘까... userInfo가 갑자기 왜나오는거지...?
        //bottom에 두니깐 하단부에 키보드 크기만큼 공간을 늘려버리는 느낌
        //만약 top에 keyboard사이즈를 넣어버리면,상단에 키보드크기만큼 공간이 늘어남.
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        scrollView.contentInset.bottom = keyboardFrame.size.height
        
        //@@@@@@@@@@@@@ 이게 뭘말하는건지 모르겠다.
        let firstResponder = UIResponder.currentFirstResponder
        
        if let textView = firstResponder as? UITextView {
            scrollView.scrollRectToVisible(textView.frame, animated: true)
        }
        
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
