import Foundation
import UIKit
import SnapKit
import SwiftUI
import FirebaseCore
import Firebase

class AddDateVC : UIViewController {
    private var selectedDate : String = ""
    let formatDate = DateFormatter()
    private var ref : DatabaseReference!
    
    
    
    
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
        setNotification()
        setTapMethod()
        addView()
        setAutoLayout()
    }
    
    //MARK: - setUpView
    private func setAutoLayout(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.frame.width)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalToSuperview().inset(30)
            
        }
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().inset(30)
        }
        testName.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
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
        formatDate.dateFormat = "yyyy-MM-dd"
        let myDate = formatDate.string(from: sender.date)
        selectedDate = myDate
    }
    @objc private func saveDateData(){
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        ref = Database.database().reference().child("Users").child(uid).child("MyTests").childByAutoId()
        let data = [
            "testNmae": "myTest",
            "selectedDate": selectedDate
        ]
        ref.setValue(data)
        
        //뷰가너무 빨리닫힘.
        dismiss(animated: true)
    }
    
    //MARK: - setNotification
    private func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
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
    
    //MARK: - tabAtction
    //스크롤뷰 Tab할시 수행할 기능.
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


//MARK: - preview
#if DEBUG
struct addDateVC : UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){

    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        AddDateVC()
    }
}
@available(iOS 13.0, *)
struct addDateVC_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            addDateVC()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif

