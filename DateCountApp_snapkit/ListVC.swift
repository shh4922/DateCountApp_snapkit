import SnapKit
import SwiftUI
import UIKit
import Firebase
class ListVC: UIViewController {
    private lazy var loginVC : UINavigationController = {
        let loginVC = LoginVC()
        let navLoginVC = UINavigationController(rootViewController: loginVC)
        
        return navLoginVC
    }()
    
    private lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .white
//        imgView.image = UIImage(named: "Myimg2")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "오늘의 글귀"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 35)
        
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
        text1.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 20)
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
        self.navigationItem.title = "hihihiihi gyoen"
//        self.navigationItem.rightBarButtonItem
        view.backgroundColor = .systemYellow
//        view.addSubview(imgView)
        view.addSubview(titleLabel)
        view.addSubview(text1)
        view.addSubview(testButton)
//        imgView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
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
        let auth = Auth.auth()
        print("logout!!")
        do {
            try auth.signOut()
            UserDefaults.standard.set(false, forKey: "isLogin")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
        }catch let signOutError {
            print("로그아웃에러!!!!!!!!!!!!!@@@@@@@@@@@@@@@@!!@!@!@!@")
            print(signOutError)
        }
 
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
