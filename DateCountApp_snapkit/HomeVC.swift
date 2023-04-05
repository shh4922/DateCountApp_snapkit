import Firebase
import UIKit
import SnapKit
import SwiftUI

class HomeVC: UIViewController{
    
    var dataSource = [DateModel]()
    
    private lazy var dateTableView : UITableView = {
        let dateTableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame, style: .insetGrouped)
        //테이블뷰 라인 제거.
        dateTableView.separatorStyle = .none
        dateTableView.backgroundColor = .systemGroupedBackground
        dateTableView.layer.cornerRadius = 10
        return dateTableView
    }()
    private lazy var topView : UIView = {
        let topview = UIView()
        topview.backgroundColor = .systemGroupedBackground
        topview.layer.cornerRadius = 10
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
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 0
        textLabel.text = "잘하고싶다 배고프다 운동은 왜안했냐 시벌.. 책읽어야징 낼 학교가기싫다 음 불평만 하고있네 신현호 너 잘하고있다 계속이렇게만 꾸준히해 그럼 무조건 잘해진다 오키??똥싸고싶다 잘하고?"
        return textLabel
    }()
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(onClickPlusBtn))
        return button
    }()
    
    //layout제약조건 및 설정
    private func setAutoLayout(){
        topView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.left.equalTo(view.safeAreaLayoutGuide).offset(10)
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
        view.addSubview(topView)
        topView.addSubview(titleLabel)
        topView.addSubview(textLabel)
        view.addSubview(dateTableView)
        
    }
    
    //특정기능을 위한 setup
    private func setupView(){
        print("HomeVC - setupView")
        view.backgroundColor = .white
        
        
        dateTableView.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.identifier)
        //tableview의 델리게잇 지정.
        dateTableView.delegate = self
        dateTableView.dataSource = self
        
    }
    
    //사용자의 시험일정등의 데이터를 받아오는곳.
    private func loadDate(){
        print("HomeVC - runLoadDate")
        dataSource.append(.init(dateCount: 123, testName: "정처기"))
        dataSource.append(.init(dateCount: 213, testName: "전기기사"))
        dataSource.append(.init(dateCount: 11243, testName: "수능"))
        dataSource.append(.init(dateCount: 11, testName: "중간고사"))
        
        dateTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC - viewWillAppear")
        addView()
        setAutoLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeVC - viewDidLoad")
        self.navigationItem.rightBarButtonItem = self.rightButton
        setupView()
        loadDate()
        self.navigationItem.rightBarButtonItem = self.rightButton
    }
    
    @objc private func onClickPlusBtn(){
        print("onClick!!!!")
    }
    
}

// TableView를 위해 추가한 것들.
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    //셀의 개수를 리턴해주는것.
    //셀의개수 = dataSource의 개수 -> dataSource에 샐들이 들어있으니깐.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return dataSource.count}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier) as? DateTableViewCell ?? DateTableViewCell()
        
        cell.bind(model: dataSource[indexPath.row])
        cell.backgroundColor = .systemGroupedBackground
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
