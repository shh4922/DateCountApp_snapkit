import Firebase

import UIKit
import SnapKit
import SwiftUI

class HomeVC: UIViewController{
    //MARK: - 데이터 생성.
    var userDataAry = [DateModel]()
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    
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
        topview.backgroundColor = .black
        return topview
    }()
    private lazy var textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        textLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 30)
        textLabel.numberOfLines = 0
        textLabel.text = "장고끝에 악수 둔다."
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
    private lazy var navBar : UINavigationBar = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.isTranslucent = false
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = navBar.standardAppearance
        
        return navBar
    }()
    private lazy var navItem : UINavigationItem = {
        let navItem = UINavigationItem(title: "리스트")
        let rightBarButton  = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(onClickPlusBtn))
        navItem.rightBarButtonItem = rightBarButton
        return  navItem
    }()
    
    
    //MARK: - lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            make.right.equalToSuperview()
            
        }
        topView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(100)
        }
        textLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview().offset(10)
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
        topView.addSubview(textLabel)
        view.addSubview(dateTableView)
        
    }
    //특정기능을 위한 setup
    private func setupView(){
        view.backgroundColor = .white
        navBar.setItems([navItem], animated: true)
        
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
        
        db.observeSingleEvent(of: .value){snapshot in
            //snapshot의 값을 딕셔너리 형태로 변경해줍니다.
            guard let snapData = snapshot.value as? [String:Any] else {return}
            print(snapData)
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            do{
                //데이터가 정렬되지않아있음. 선택날짜 순서로 오름차순으로 정렬후에 넣어주는걸로
                let dataList = try self.decoder.decode([DateModel].self, from: data)
                
                //sorted()에서 사용할 매개변수를 잡아주지못해서 오류가났던거같넹
                self.userDataAry = dataList.sorted(by: { $0.selectedDate < $1.selectedDate })
                
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
        
        if let selectedDate = cell.selectedDate.text {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let selectedDate_ = dateFormatter.date(from: selectedDate){
                
                let currentDate = Date()
                let calendar = Calendar.current
                
                //아래코드는 시간차로 인한 날짜오류가 생겨서, 달력날짜를 기준으로 두 날의 차이를 계산하기위해 만들어줌.
                let stactOfselectedDate = calendar.startOfDay(for: selectedDate_)
                let stactOfcurrentDate = calendar.startOfDay(for: currentDate)

                
                let dateComponents = calendar.dateComponents([.day], from: stactOfcurrentDate, to: stactOfselectedDate)
                
                if let dayDifference = dateComponents.day {
                    
                    cell.dateCount.text = "\(dayDifference)"
                }
                
            }
        }
        
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
