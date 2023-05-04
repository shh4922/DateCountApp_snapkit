import SnapKit
import UIKit

class ChangeTitleTextVC: UIViewController {

    
    private lazy var titleLabel : UILabel = {
        let titleLabel =  UILabel()
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "자신만의 명언을 입력해보세요!"
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 25)
        return titleLabel
    }()
    
    private lazy var titleQuote : UITextField = {
        let titleQuote = UITextField()
        titleQuote.placeholder = "변경할 명언을 입력하세요"
        titleQuote.textColor = .black
        titleQuote.backgroundColor = UIColor(named: "textFieldColor")
        titleQuote.layer.cornerRadius = 4
        titleQuote.addLeftPadding()
        return titleQuote
    }()
    private lazy var saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 5
        saveButton.setTitle("저장", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        saveButton.addTarget(self, action: #selector(saveTitleQuote), for: .touchUpInside)
        return saveButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        addView()
        setAutoLayout()
    }
    private func addView(){
        view.addSubview(titleLabel)
        view.addSubview(titleQuote)
        view.addSubview(saveButton)
    }
    private func setAutoLayout(){
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
        titleQuote.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(110)
            make.left.equalTo(view.snp.left).offset(30)
            make.height.equalTo(70)
        }
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleQuote.snp.bottom).offset(70)
            make.left.greaterThanOrEqualTo(view.snp.left).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    private func setUP(){
        view.backgroundColor = .white
    }
    
    @objc private func saveTitleQuote(){
        UserDefaults.standard.setValue(titleQuote.text, forKey: "titleQuote")
        NotificationCenter.default.post(name: Notification.Name("newQuoteInput"), object: nil)
        dismiss(animated: true)
    }

}
