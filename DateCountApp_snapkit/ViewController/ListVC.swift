import SnapKit
import SwiftUI
import UIKit
import Firebase


class ListVC: UIViewController , UNUserNotificationCenterDelegate {
    
    
    let listViewModel = ListViewModel()
    private lazy var loginVC : UINavigationController = {
        let loginVC = LoginVC()
        let navLoginVC = UINavigationController(rootViewController: loginVC)
        return navLoginVC
    }()
    private lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .black
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
        text1.text = ""
        text1.textColor = .white
        text1.numberOfLines = .zero
        text1.textAlignment = .center
        text1.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 20)
        return text1
    }()
    private lazy var author : UILabel = {
        let author = UILabel()
        author.text = ""
        author.textColor = .white
        author.numberOfLines = .zero
        author.textAlignment = .center
        author.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 15)
        return author
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addView()
        setLayout()
        navBar.setItems([navItem], animated: true)
        
        if UserDefaults.standard.bool(forKey: "isSendedText") {
            print("getTextOnFirebase호출")
            getTextOnFirebase()
            
            UserDefaults.standard.set(false, forKey: "isSendedText")
            
        }
        
        print("false로 변경됌")
        setQuoteUpdate()
        
    }
    
    
    //MARK: - init
    
    private func addView(){
        view.addSubview(imgView)
        imgView.addSubview(text1)
        imgView.addSubview(author)
        imgView.addSubview(subscriveButton)
    }
    private func setLayout(){
        view.backgroundColor = .black
        
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

        subscriveButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
            make.left.greaterThanOrEqualToSuperview().offset(100)
        }
    }
    
    
    //MARK: - Method
    @objc private func onClickPlusBtn(){
        print("testOnClick")
    }

    @objc private func getTextOnFirebase(){
        
        listViewModel.loadQuoteData() { allQuote, showedQuote in
            let random = self.listViewModel.returnRandomQuote(allQuote, showedQuote)
            
            if random != nil {
                guard let random else {return}
                self.listViewModel.saveToFirebase(quoteData: random)
                self.listViewModel.saveToLoacl(quoteData: random)
                return
            }else{
                print("random널이래 ㅋㅋ")
            }
            
            return
        }
        
    }
    
    //MARK: - ViewMethod
    private func setQuoteUpdate(){
        guard let loadedDic = UserDefaults.standard.dictionary(forKey: "myDictionary") else {return}
        text1.text = loadedDic["text"] as? String ?? ""
        author.text = loadedDic["author"] as? String ?? ""
        
    }
    
    
}
