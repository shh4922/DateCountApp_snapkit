import Firebase
import UIKit
import SnapKit
import SwiftUI

class HomeVC: UIViewController{
    
    var dataSource = [DateModel]()
    
    private lazy var dateTableView : UITableView = {
        let dateTableView = UITableView()
        //테이블뷰 라인 제거.
        dateTableView.separatorStyle = .none
        return dateTableView
    }()
    
    //layout제약조건 및 설정
    private func setAutoLayout(){
        view.backgroundColor = .white
        dateTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view).offset(40)
        }
        dateTableView.backgroundColor = .white
    }
    
    //뷰에 추가해야할 하위뷰들 넣어주는곳.
    private func addView(){
        view.addSubview(dateTableView)
    }
    
    //특정기능을 위한 setup
    private func setupView(){
        print("HomeVC - setupView")
        dateTableView.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.identifier)
        //하단 코드가 무엇을뜻하는지 모르겠음.
        dateTableView.delegate = self
        dateTableView.dataSource = self
    
    }
    
    //사용자의 시험일정등의 데이터를 받아오는곳.
    private func loadDate(){
        print("HomeVC - runLoadDate")
        dataSource.append(.init(dateCount: 123, testName: "asddsa"))
        dataSource.append(.init(dateCount: 213, testName: "asddsa"))
        dataSource.append(.init(dateCount: 11243, testName: "asddsa"))
        dataSource.append(.init(dateCount: 11, testName: "asddsa"))

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
        
        setupView()
        loadDate()
    }
    
    @objc private func onClickPlusBtn(){
        
    }
    
}

// TableView를 위해 추가한 것들.
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    //셀의 개수를 리턴해주는것.
    //셀의개수 = dataSource의 개수 -> dataSource에 샐들이 들어있으니깐.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier) as? DateTableViewCell ?? DateTableViewCell()
        cell.bind(model: dataSource[indexPath.row])
        
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
