import Firebase
import UIKit
import SnapKit
import SwiftUI

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataSource = [DateModel]()
    
    private lazy var dateTableView : UITableView = {
       let dateTableView = UITableView()
        view.addSubview(dateTableView)
        
        dateTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view).offset(40)
        }
        dateTableView.backgroundColor = .white
        
        return dateTableView
    }()
    
    private func setupView(){
        print("HomeVC - setupView")
        dateTableView.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.identifier)
        //하단 코드가 무엇을뜻하는지 모르겠음.
        dateTableView.delegate = self
        dateTableView.dataSource = self
    }
    
    private func loadDate(){
        print("HomeVC - runLoadDate")
        dataSource.append(.init(dateCount: "123", testName: "정보처리기사"))
        dataSource.append(.init(dateCount: "143", testName: "전기기사"))
        dataSource.append(.init(dateCount: "235", testName: "소방기사"))
//        dataSource.append(.init(currentDate: "2023년.12월.21일", selectDate: "2024년.1월.24일", testName: "정보처리기사"))
//        dataSource.append(.init(currentDate: "2025년.5월.21일", selectDate: "2027년.6월.13일", testName: "전기기사"))
        dateTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier) as? DateTableViewCell ?? DateTableViewCell()
        cell.bind(model: dataSource[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 56
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        loadDate()
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
