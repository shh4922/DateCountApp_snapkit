import SnapKit
import SwiftUI
import UIKit
import Firebase


class HomeVC: UIViewController , UNUserNotificationCenterDelegate {
    
    
    let homeViewmodel = HomeViewModel()
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
    private lazy var hstack : UIStackView = {
        let hstack = UIStackView()
        hstack.spacing = 50
        hstack.axis = .horizontal
        hstack.distribution = .fillEqually
        hstack.alignment = .fill
        return hstack
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
        addView()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "isSendedText") {
            getTextOnFirebase()
            UserDefaults.standard.set(false, forKey: "isSendedText")
        }
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
            make.top.equalTo(imgView.snp.top).offset(250)
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

    @objc private func getTextOnFirebase(){
        homeViewmodel.loadQuoteData() { allQuote, showedQuote in
            let random = self.homeViewmodel.returnRandomQuote(allQuote, showedQuote)
            if random != nil {
                guard let random else {return}
                self.homeViewmodel.saveToFirebase(quoteData: random)
                self.homeViewmodel.saveToLoacl(quoteData: random)
                return
            }
            return
        }
        
    }
    
    //MARK: - ViewMethod
    private func setQuoteUpdate(){
        guard let loadedDic = UserDefaults.standard.dictionary(forKey: "myDictionary") else {return}
        text1.text = loadedDic["quote"] as? String ?? ""
        author.text =  loadedDic["author"] as? String ?? "" 
    }
    
    
}


