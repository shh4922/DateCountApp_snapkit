import Firebase

import UIKit
import SnapKit
import SwiftUI

class HomeVC: UIViewController{
    //MARK: - 데이터 생성.
    var userDataAry = [DateModel]()
    let decoder = JSONDecoder()
    
    
    private lazy var dateTableView : UITableView = {
        let dateTableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame, style: .insetGrouped)
        dateTableView.layer.cornerRadius = 10
        dateTableView.backgroundColor = .systemBackground
        dateTableView.separatorStyle = .none
        return dateTableView
    }()
    private lazy var topView : UIView = {
        let topview = UIView()
        topview.layer.cornerRadius = 10
        topview.backgroundColor = .systemGray5
        return topview
    }()
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.text = "오늘의 명언"
        return titleLabel
    }()
    private lazy var textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.textColor = .black
        textLabel.font = UIFont(name: "Dovemayo_gothic", size: 20)
        textLabel.numberOfLines = 0
        textLabel.text = "잘하고싶다 배고프다 운동은 왜안했냐 시벌.. 책읽어야징 낼 학교가기싫다 음 불평만 하고있네 신현호 너 잘하고있다 계속이렇게만 꾸준히해 그럼 무조건 잘해진다 오키??똥싸고싶다 잘하고?"
        return textLabel
    }()
//    private lazy var rightButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("add", for: .normal)
//        button.setTitleColor(.systemBlue, for: .normal)
//        button.addTarget(self, action: #selector(onClickPlusBtn), for: .touchUpInside)
//
//        return button
//    }()
//    private lazy var navBar : UINavigationBar = {
//        var statusBarHeight: CGFloat = 0
//        statusBarHeight = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
//        let navBar = UINavigationBar(frame: .init(x: 0, y: statusBarHeight, width: view.frame.width, height: statusBarHeight))
////        let navVar = UINavigationBar(.init(x: 0, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
//        navBar.backgroundColor = .systemBackground
//        navBar.isTranslucent = false
//
//        let navItem = UINavigationItem(title: "홈입니당")
//        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onClickPlusBtn))
//        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(onClickPlusBtn))
//        navBar.items = [navItem]
//        return navBar
//    }()
    
    private lazy var navBar : UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 40))
        navBar.barStyle = .default
        //반투명
        navBar.isTranslucent = false
        navBar.backgroundColor = .lightGray
        navBar.items = [navItem]
        return navBar
    }()
    private lazy var rightBarButton : UIBarButtonItem = {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(onClickPlusBtn), for: .touchUpInside)
        let rightBarButton  = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(onClickPlusBtn))
        
        return  rightBarButton
    }()
    private lazy var navItem : UINavigationItem = {
        let navItem = UINavigationItem()
        navItem.rightBarButtonItem = rightBarButton
//        navItem.leftBarButtonItem
        return navItem
    }()
    
    @objc private func test1(){
        print("addTest run")
    }
    
    //MARK: - lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        loadDate()
        loadTestData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addView()
        setAutoLayout()
        
    }
    
    //MARK: - setUpView
    //layout제약조건 및 설정
    private func setAutoLayout(){
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(view.frame.width)
        }
        topView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(200)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)

        }
        dateTableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(40)
        }
    }
    //뷰에 추가해야할 하위뷰들 넣어주는곳.
    private func addView(){
        view.addSubview(navBar)
        view.addSubview(topView)
        topView.addSubview(titleLabel)
        topView.addSubview(textLabel)
        view.addSubview(dateTableView)
        
    }
    //특정기능을 위한 setup
    private func setupView(){
        view.backgroundColor = .systemBackground
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        
        
        //어떤 셀을 가져올지 정해줘야함.
        dateTableView.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.identifier)
        //tableview의 델리게잇 지정.
        dateTableView.delegate = self
        dateTableView.dataSource = self
        dateTableView.rowHeight = 100
        
    }
    
    
    //MARK: - 테스트코드
    private func loadTestData(){
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        let db = Database.database().reference().child("Users").child(uid).child("MyTests")
        
        db.observeSingleEvent(of: .value){ snapshot in
            //snapshot의 값을 딕셔너리 형태로 변경해줍니다.
            guard let snapData = snapshot.value as? [String:Any] else {return}
            
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            do{
                let dataList = try self.decoder.decode([DateModel].self, from: data)
                self.userDataAry = dataList
                DispatchQueue.main.async {
                    self.dateTableView.reloadData()
                }
            }catch let error {
                print(error)
            }
            
        }
    }
    

    // ShowAddView
    @objc private func onClickPlusBtn(){
        print("onClick!!!!")
        let pushVC = AddDateVC()
        pushVC.modalTransitionStyle = .coverVertical
        pushVC.modalPresentationStyle = .automatic
        //일부러 present로 함, nav로 하면 좀 생동감이없어서,
        self.present(pushVC, animated: true, completion: nil)

    }
    
}

//MARK: - tableViewSetUp
// TableView를 위해 추가한 것들.
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    //셀의 개수를 리턴해주는것.
    //셀의개수 = dataSource의 개수 -> dataSource에 샐들이 들어있으니깐.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataAry.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier) as? DateTableViewCell ?? DateTableViewCell()
        
        cell.bind(model: userDataAry[indexPath.row])
        cell.dateCount_default.text = "D - "
        
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        if let selectedDate = cell.selectedDate.text {
//            let convertDate = dateFormatter.date(from: selectedDate)
//            let today = Data()
//            let numberOfDays = Calendar.current.dateComponents([.day], from: today, to: convertDate) // <3>
//
//            return numberOfDays.day!
//        }
//
        
        
        
        cell.dateCount.text = "123"
        //셀 선택시, 색상나오는거 안보이게 함.
        cell.selectionStyle = .none
        return cell
    }
}


#if DEBUG
struct HomeView: UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){

    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        HomeVC()
    }
}
@available(iOS 13.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            HomeView()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif
