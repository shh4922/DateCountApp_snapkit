import Foundation
import UIKit
import SnapKit
import SwiftUI


class AddDateVC : UIViewController {
    private var selectedDate : String? = nil
    let formatDate = DateFormatter()
    let addDateViewModel = AddDateViewModel()
    
    
    //MARK: - createUI
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var contentView : UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "새로운 일정을 추가하세요!"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        return titleLabel
    }()
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        //년,월,일
        picker.datePickerMode = .date
        //모드설정
        picker.preferredDatePickerStyle = .wheels
        
        picker.locale = Locale(identifier: "ko_KR")
        picker.calendar.locale = Locale(identifier: "ko_KR")
        picker.timeZone = .autoupdatingCurrent
        picker.sizeToFit()
        //        picker.date = Date(timeIntervalSinceNow: -3600 * 24 * 3)
        picker.addTarget(self, action: #selector(selectDate(_:)), for: .valueChanged)
        picker.minimumDate = Date()
        return picker
    }()
    private lazy var testName : UITextField = {
        let testName = UITextField()
        testName.placeholder = "시험이름을 입력하세요"
        testName.textColor = .black
        testName.backgroundColor = UIColor(named: "textFieldColor")
        testName.layer.cornerRadius = 4
        testName.addLeftPadding()
        //        testName.delegate = self
        return testName
    }()
    private lazy var okButton : UIButton = {
        let okButton = UIButton()
        okButton.backgroundColor = .systemBlue
        okButton.layer.cornerRadius = 5
        okButton.setTitle("저장", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        okButton.addTarget(self, action: #selector(saveDateData), for: .touchUpInside)
        return okButton
    }()
    
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUp()
        setNotification()
        setTapMethod()
        addView()
        setAutoLayout()
    }
    
    //MARK: - 기본setUp
    private func setUp(){
        
        formatDate.dateFormat = "yyyy-MM-dd"
        selectedDate = formatDate.string(from: Date())
    }
    
    
    //MARK: - setUpView
    private func setAutoLayout(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }
        titleLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).offset(-30)
        }
        datePicker.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).offset(-30)
        }
        testName.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(30)
//            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        okButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(testName.snp.bottom).offset(80)
            make.left.equalToSuperview().inset(80)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
    }
    private func addView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(testName)
        contentView.addSubview(okButton)
    }
    
    //MARK: - method
    @objc private func selectDate(_ sender: UIDatePicker){
        selectedDate = formatDate.string(from: sender.date)
    }
    
    @objc private func saveDateData(){
        //만약 날자를 선택하지않고, 바로 저장을 눌렀을경우 -> "" 이 날자에 들어가게됌/
        guard let selectedDate else { return }
        guard let testname = testName.text else {return}
        
        if testname == "" {
            // 모두 입력하라고 알림
            return
        }
        
        addDateViewModel.saveDateToFirebase(selectedDate: selectedDate, testName: testname)
        
        dismiss(animated: true)
    }
    
    //MARK: - setNotification
    private func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

}

extension AddDateVC {
    //MARK: - 키보드 셋업
    
    //키보드가 보여질시 스크롤이 가능하도록 하기위해서 contentInset 조정
    @objc private func keyboardWillShow(_ notification : Notification){
        print("signUpVC keyboardWillShow()-run")
        //키보드가 올라오면
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    //키보드가 사라질시 contentInset.zero
    @objc private func keyboardWillHide(){
        print("signUpVC keyboardWillHide()-run")
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
    }
    
    //MARK: - Keyboard tabAtction
    @objc private func RunTapMethod(){
        self.view.endEditing(true)
    }
    
    private func setTapMethod(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RunTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
}
