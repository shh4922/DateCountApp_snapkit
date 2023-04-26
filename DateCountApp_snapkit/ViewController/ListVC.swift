import Firebase

import UIKit
import SnapKit
import SwiftUI

class ListVC: UIViewController{
    //MARK: - 데이터 생성.
    var userDataAry = [Testmodel]()
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    let homeViewModel = ListViewModel()
    
    private lazy var dateTableView : UITableView = {
        let dateTableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame, style: .insetGrouped)
        dateTableView.layer.cornerRadius = 10
        dateTableView.backgroundColor = .white
        dateTableView.separatorStyle = .none
        return dateTableView
    }()
    private lazy var topView : UIView = {
        let topview = UIView()
        topview.layer.cornerRadius = 10
        topview.backgroundColor = .systemGray5
        return topview
    }()
    private lazy var textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.textColor = .black
        textLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 30)
        textLabel.numberOfLines = 0
        textLabel.text = "장고끝에 악수 둔다."
        return textLabel
    }()
    private lazy var navBar : UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.barTintColor = .systemGray5
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
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotification()
        setupView()
        addView()
        setAutoLayout()
        loadTestData()
        
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
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
        view.backgroundColor = .systemGray5
        navBar.setItems([navItem], animated: true)
        
        //어떤 셀을 가져올지 정해줘야함.
        dateTableView.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.identifier)
        //tableview의 델리게잇 지정.
        dateTableView.delegate = self
        dateTableView.dataSource = self
        dateTableView.rowHeight = 100
        
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.dateTableView.reloadData()
        }
    }
    
    //MARK: - 테스트코드
    @objc private func loadTestData(){
        homeViewModel.loadTestData { result in
            if result.isEmpty {
                return
            }
            self.reloadTableView()
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

extension ListVC {
    private func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(loadTestData), name: Notification.Name("newDataAdded"), object: nil)
    }
    
}

//MARK: - tableViewSetUp
// TableView를 위해 추가한 것들.
extension ListVC : UITableViewDelegate, UITableViewDataSource {
    
    //셀의 개수를 리턴해주는것.
    //셀의개수 = dataSource의 개수 -> dataSource에 샐들이 들어있으니깐.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.returnCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier) as? DateTableViewCell ?? DateTableViewCell()
        
        cell.bind(model: homeViewModel.userDataAry[indexPath.row])
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
                    if dayDifference == 0{
                        cell.dateCount.text = " day"
                    }else if dayDifference > 0 {
                        cell.dateCount.text = "\(dayDifference)"
                    }else{
                        cell.dateCount.text = " 마감"
                    }
                    
                }
                
            }
        }
        
        //셀 선택시, 색상나오는거 안보이게 함.
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            homeViewModel.removeFromFirebase(index: indexPath.row)
            homeViewModel.userDataAry.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
        }
    }
}
