import SnapKit
import Foundation

class AllQuoteVC : UIViewController, UITableViewDelegate{
   
    let homeViewModel = HomeViewModel()
    
    private lazy var quoteTableView : UITableView = {
        let quoteTableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame, style: .insetGrouped)
        quoteTableView.layer.cornerRadius = 10
        quoteTableView.backgroundColor = .white
        quoteTableView.separatorStyle = .none
        return quoteTableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        quoteTableView.register(AllQuoteTableViewCell.self, forCellReuseIdentifier: AllQuoteTableViewCell.identifier)
        
        quoteTableView.dataSource = self
        quoteTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addView()
        setAutoLayout()
    }
    
    private func addView(){
        view.addSubview(quoteTableView)
    }
    private func setAutoLayout(){
        quoteTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension AllQuoteVC : UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(homeViewModel.showedData.count)
        return homeViewModel.showedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //일단 셀을 만듬
        let cell = tableView.dequeueReusableCell(withIdentifier: AllQuoteTableViewCell.identifier) as? AllQuoteTableViewCell ?? AllQuoteTableViewCell()
        
        cell.bind(model: homeViewModel.showedData[indexPath.row])
        
        return cell
    }
}
