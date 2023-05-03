import FirebaseAuth
import UIKit
import SnapKit
import SwiftUI

class ListVC: UIViewController{
    //MARK: - 데이터 생성.
    let decoder = JSONDecoder()
    let listViewModel = ListViewModel()
    var titleQuote : String = UserDefaults.standard.string(forKey: "titleQuote") ?? ""
    
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
        textLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 26)
        textLabel.numberOfLines = 0
        titleQuote == "" ? (textLabel.text = "자신만의 명언을 입력학세요") : (textLabel.text = titleQuote)
        return textLabel
    }()
    private lazy var navBar : UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.barTintColor = .systemGray5
        return navBar
    }()
    private lazy var navItem : UINavigationItem = {
        let navItem = UINavigationItem(title: "나의시험")
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
        setTabLabel()
        setupView()
        addView()
        setAutoLayout()
        loadTestData()
    }
    
    //MARK: - setUpView
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
    private func addView(){
        view.addSubview(navBar)
        view.addSubview(topView)
        topView.addSubview(textLabel)
        view.addSubview(dateTableView)
        
    }
    private func setupView(){
        view.backgroundColor = .systemGray5
        navBar.setItems([navItem], animated: true)
        dateTableView.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.identifier)
        dateTableView.delegate = self
        dateTableView.dataSource = self
        dateTableView.rowHeight = 100
        
    }
    
    
    @objc private func changeTopQuote(){
        let pushVC = ChangeTitleTextVC()
        pushVC.modalTransitionStyle = .coverVertical
        pushVC.modalPresentationStyle = .automatic
        //일부러 present로 함, nav로 하면 좀 생동감이없어서,
        self.present(pushVC, animated: true, completion: nil)
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.dateTableView.reloadData()
        }
    }
    
    //MARK: - 테스트코드
    @objc private func loadTestData(){
        listViewModel.loadTestData { result in
            if result.isEmpty {
                return
            }
            self.reloadTableView()
        }
    }
    @objc private func loadTitleQuote(){
        self.titleQuote = UserDefaults.standard.string(forKey: "titleQuote") ?? ""
        DispatchQueue.main.async{
            print("loadTitleQuote run")
            self.textLabel.text = self.titleQuote
        }
    }
    // ShowAddView
    @objc private func onClickPlusBtn(){
        let pushVC = AddDateVC()
        pushVC.modalTransitionStyle = .coverVertical
        pushVC.modalPresentationStyle = .automatic
        self.present(pushVC, animated: true, completion: nil)
        
    }
    
    
    
}

extension ListVC {
    private func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(loadTestData), name: Notification.Name("newDataAdded"), object: nil)
        /**
         사실 여기가 마음에걸린다.
         지금내가사용한 방법은 데이터를 추가하면, DB에 데이터를넣고, DB에서 데이터를 다시 받아와서 또 그리도록하였다.
         굳이 이렇게 해야할까.. 싶다.
         새로운데이터를 추가하면, DB에추가하고, 리스트에 데이터추가해주고, reload해주면, 데이터를 받아오지않아도되서 개이득아닐까 싶어서 좀 고려중이다.
         */
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitleQuote), name: Notification.Name("newQuoteInput"), object: nil)
    }
    private func setTabLabel(){
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(changeTopQuote))
        self.textLabel.addGestureRecognizer(tabGesture)
        self.textLabel.isUserInteractionEnabled  = true
    }
    
}

//MARK: - tableViewSetUp
// TableView를 위해 추가한 것들.
extension ListVC : UITableViewDelegate, UITableViewDataSource {
    
    //셀의 개수를 리턴해주는것.
    //셀의개수 = dataSource의 개수 -> dataSource에 샐들이 들어있으니깐.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.returnCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier) as? DateTableViewCell ?? DateTableViewCell()
        
        cell.bind(model: listViewModel.userDataAry[indexPath.row])
        cell.dateCount_default.text = "D - "
        cell.dateCount.text = self.listViewModel.countDate(selectedDate: self.listViewModel.userDataAry[indexPath.row].selectedDate)
        //셀 선택시, 색상나오는거 안보이게 함.
        cell.selectionStyle = .none
        return cell
    }
    
    // 셀을 지울때
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listViewModel.removeFromFirebase(index: indexPath.row)
            listViewModel.userDataAry.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
}
