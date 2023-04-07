import SnapKit
import SwiftUI
import UIKit

class ListVC: UIViewController {
    private lazy var loginVC : LoginVC = {
        let loginVC = LoginVC()
        return loginVC
    }()
    
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "오늘의 글귀"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 30)
        
        return titleLabel
    }()
    private lazy var testButton : UIButton = {
        let testButton = UIButton()
        testButton.backgroundColor = .green
        testButton.setTitle("로그아웃!!", for: .normal)
        testButton.setTitleColor(.white, for: .normal)
        testButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return testButton
    }()
    
    private lazy var text1 : UILabel = {
        let text1 = UILabel()
        text1.text = "뭉치면 살고 흩어지면 죽는다. 하지만 나는 너무 배가고프다 그렇기떄문에 밥을 먹어야한다. 슈바암ㅇㄴ암ㄴ이ㅏㅓㅁㄴ이ㅏㅁㄴㄴ머 \n asdasd asdasdas\n asdasd 뭉치면 살고 흩어지면 죽는다. 하지만 나는 너무 배가고프다 그렇기떄문에 밥을 먹어야한다"
        text1.textColor = .black
        text1.numberOfLines = .zero
        text1.textAlignment = .center
        return text1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayout()
    }
    
    private func setLayout(){
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(text1)
        view.addSubview(testButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.equalToSuperview().offset(30)
        }
       

        text1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
        }
        testButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(text1.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
        }
    }

    @objc func logout(){
        print("logout!!")
        UserDefaults.standard.string(forKey: "userName")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
    }
}



#if DEBUG
struct ListView: UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){

    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ListVC()
    }
}
@available(iOS 13.0, *)
struct ListView_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            ListView()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif
