import SnapKit
import SwiftUI
import UIKit
import Firebase
import os.log

class ListVC: UIViewController , UNUserNotificationCenterDelegate {
    
    var myData : Set<[String:String]> = Set()
    
    private lazy var loginVC : UINavigationController = {
        let loginVC = LoginVC()
        let navLoginVC = UINavigationController(rootViewController: loginVC)
        return navLoginVC
    }()
    private lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .black
        //        imgView.image = .checkmark
        return imgView
    }()
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "오늘의 글귀"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 35)
        
        return titleLabel
    }()
    private lazy var hstack : UIStackView = {
        let hstack = UIStackView()
        hstack.spacing = 50
        hstack.axis = .horizontal
        hstack.distribution = .fillEqually
        hstack.alignment = .fill
        return hstack
    }()
    private lazy var navBar : UINavigationBar = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = navBar.standardAppearance
        return navBar
    }()
    private lazy var navItem : UINavigationItem = {
        let navItem = UINavigationItem(title: "text")
        navItem.titleView?.tintColor = .white
        let rightBarButton  = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(onClickPlusBtn))
        navItem.rightBarButtonItem = rightBarButton
        return  navItem
    }()
    private lazy var changeImageButton : UIButton = {
        let icon = UIImage(systemName: "tray")
        let changeButton = UIButton()
        changeButton.layer.cornerRadius = 10
        changeButton.backgroundColor = .white
        changeButton.setImage(icon, for: .normal)
        return changeButton
    }()
    private lazy var subscriveButton : UIButton = {
        let icon = UIImage(systemName: "heart")
        let subscriveButton = UIButton()
        subscriveButton.layer.cornerRadius = 10
        subscriveButton.backgroundColor = .white
        subscriveButton.setImage(icon, for: .normal)
        return subscriveButton
    }()
    private lazy var text1 : UILabel = {
        let text1 = UILabel()
        text1.text = "젠이츠 관철해내거라 \n 울어도 좋아 도망쳐도 좋아 \n 다만 포기만은 하지 말거라. \n 믿는거다 \n 극한까지 벼려내어 누구보다도 강인한 칼날이 되는거다"
        text1.textColor = .white
        text1.numberOfLines = .zero
        text1.textAlignment = .center
        text1.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 20)
        return text1
    }()
    private lazy var author : UILabel = {
        let author = UILabel()
        author.text = "작가임"
        author.textColor = .white
        author.numberOfLines = .zero
        author.textAlignment = .center
        author.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 15)
        return author
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "isSendedText") {
            getTextOnFirebase()
            print("투루임!!")
        }else{
            if let loadedDic = UserDefaults.standard.dictionary(forKey: "myDictionary"){
                text1.text = loadedDic["text"] as? String ?? ""
                author.text = loadedDic["author"] as? String ?? ""
            }
            print("투루아님..")
        }
        
        UserDefaults.standard.set(false, forKey: "isSendedText")
        print("false로 바꿈")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayout()
        navBar.setItems([navItem], animated: true)
        
    }
    @objc private func onClickPlusBtn(){
        print("sd")
    }
    private func saveUserDefaultTextData(){
        
    }
    
    private func setLayout(){
        
        view.backgroundColor = .black
        
        //        view.addSubview(navBar)
        view.addSubview(imgView)
        imgView.addSubview(text1)
        imgView.addSubview(author)
        imgView.addSubview(hstack)
        hstack.addArrangedSubview(changeImageButton)
        hstack.addArrangedSubview(subscriveButton)
        
        
        imgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        text1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(imgView.snp.top).offset(100)
        }
        author.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(text1.snp.bottom).offset(10)
        }
        hstack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.bottom.equalTo(imgView.snp.bottom).offset(-100)
            make.left.greaterThanOrEqualTo(100)
        }
        changeImageButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        subscriveButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    //밑에 두 observeSingleEvent가 비동기로 작업해서, 명언 데이터를 받아오기전에 UI를 그려버려서  데이터를 보여주지못한다
    @objc private func getTextOnFirebase(){
        
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("info").child("deleveredData")
        let TextDB = Database.database().reference().child("textdata")
        let group = DispatchGroup() // DispatchGroup 생성
        
        
        group.enter()
        TextDB.observeSingleEvent(of: .value){ snapshot in
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let text = snap.childSnapshot(forPath: "text").value as? String else { return }
                guard let author = snap.childSnapshot(forPath: "author").value as? String else { return }
                let decodeText = text.applyingTransform(.init("Any-Hex/Java"), reverse: true) ?? text
                let decodeAuthor = author.applyingTransform(.init("Any-Hex/Java"), reverse: true) ?? author
                self.myData.insert([
                    "text": decodeText,
                    "author" : decodeAuthor
                ])
                print("들어간 데이터는 \(self.myData)")
            }
            group.leave()
        }
        
        group.enter()
        DeleveredDB.observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children{
                guard let snap = child as? DataSnapshot else { return }
                guard let text = snap.childSnapshot(forPath: "text").value as? String else { return }
                guard let author = snap.childSnapshot(forPath: "author").value as? String else { return }
                self.myData.remove([
                    "text": text,
                    "author" : author
                ])
                print("남은 데이터는 \(self.myData)")
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) { // 모든 작업이 완료된 후 실행될 클로저
            let randomData = self.myData.randomElement()
            self.text1.text = randomData?["text"]
            self.author.text = randomData?["author"]
            
            DeleveredDB.childByAutoId().setValue([
                "text" : randomData?["text"],
                "author" : randomData?["author"]
            ])
            UserDefaults.standard.set(
                [
                "text" : randomData?["text"],
                "author" : randomData?["author"]
                ],
                forKey: "myDictionary"
            )
            
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
