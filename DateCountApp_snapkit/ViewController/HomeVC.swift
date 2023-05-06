import SnapKit
import SwiftUI
import UIKit
import FirebaseAuth


class HomeVC: UIViewController , UNUserNotificationCenterDelegate {
    
    let homeViewmodel = HomeViewModel()
    
    private lazy var loginVC : UINavigationController = {
        let loginVC = LoginVC()
        let navLoginVC = UINavigationController(rootViewController: loginVC)
        return navLoginVC
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
        showDialogMassage()
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
        view.addSubview(text1)
        view.addSubview(author)
    }
    private func setLayout(){
        view.backgroundColor = .black
        text1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(250)
        }
        author.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(text1.snp.bottom).offset(10)
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
    
    @objc func showDialogMassage(){
        let alert = UIAlertController(title: "경고!", message: "알람을 거부하면 멍언이 오지않습니다ㅠㅠㅠ \n 설정에서 권한을 승인해주세요!", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
 
}

