import SnapKit
import UIKit

class SetTimeVC : UIViewController {
    
    let dateFormater = DateFormatter()
    var hour : String = ""
    var minute : String = ""
    
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "명언을 받을 시간을 설정하세요"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    private lazy var subLabel : UILabel = {
        let subLabel = UILabel()
        subLabel.text = "24시를 기준으로 설정합니다."
        subLabel.textAlignment = .center
        subLabel.font = .boldSystemFont(ofSize: 18)
        subLabel.numberOfLines = 0
        subLabel.textColor = .lightGray
        return subLabel
    }()
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        //년,월,일
        picker.datePickerMode = .time
        //모드설정
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "en_GB")
        picker.timeZone = .autoupdatingCurrent
        picker.sizeToFit()
        picker.addTarget(self, action: #selector(selectDate(_:)), for: .valueChanged)
        return picker
    }()
    private lazy var saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("설정완료", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveTime), for: .touchUpInside)
        return saveButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setAutoLayout()
        setUp()
    }
    
    //MARK: - setUp
    private func addView(){
        view.addSubview(titleLabel)
        view.addSubview(subLabel)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
        
    }
    private func setAutoLayout(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel.snp.bottom).offset(100)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(30)
            make.height.equalTo(130)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
    }
    private func setUp(){
        view.backgroundColor = .white
    }
    @objc private func selectDate(_ sender: UIDatePicker){

        dateFormater.dateFormat = "HH"
        var formatTime = dateFormater.string(from: sender.date)
        hour = formatTime
        
        dateFormater.dateFormat = "mm"
        formatTime = dateFormater.string(from: sender.date)
        minute = formatTime
    }
    @objc private func saveTime(){
        UserDefaults.standard.set(hour, forKey: "hour")
        UserDefaults.standard.set(minute, forKey: "minute")
        
        dismiss(animated: true)
        NotificationCenter.default.post(name: Notification.Name("changeTime"), object: nil)
        
        
    }
    
    
    
}

