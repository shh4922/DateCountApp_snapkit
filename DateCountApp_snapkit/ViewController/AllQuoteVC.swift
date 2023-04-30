import SnapKit
import Foundation

class AllQuoteVC : UIViewController, allQuoteCellDelegate{
    
    let allQuoteViewModel = AllQuoteViewModel()
    
    private lazy var quoteTableView : UITableView = {
        let quoteTableView = UITableView()
        quoteTableView.backgroundColor = .white
        quoteTableView.rowHeight = UITableView.automaticDimension
        quoteTableView.estimatedRowHeight = 200
        return quoteTableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setAutoLayout()
        setUp()
        loadShowedQuoteData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        reloadTableView()
    }
    
    private func setUp(){
        view.backgroundColor = .white
        quoteTableView.register(AllQuoteTableViewCell.self, forCellReuseIdentifier: AllQuoteTableViewCell.identifier)
        quoteTableView.dataSource = self
        quoteTableView.delegate = self
    }
    private func addView(){
        view.addSubview(quoteTableView)
    }
    private func setAutoLayout(){
        quoteTableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    private func loadShowedQuoteData(){
        allQuoteViewModel.loadQuoteData { result in
            if result.isEmpty {
                return
            }
            self.reloadTableView()
        }
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            print("run reload")
            self.quoteTableView.reloadData()
        }
    }
    
    
    
}


extension AllQuoteVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuoteViewModel.showedData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllQuoteTableViewCell.identifier) as? AllQuoteTableViewCell ?? AllQuoteTableViewCell()
        cell.bind(model: allQuoteViewModel.showedData[indexPath.row])
        cell.cellDelegate = self
        cell.tag = indexPath.row
        if allQuoteViewModel.showedData[indexPath.row].isLike == 1 {
            cell.likeButton.tintColor = .red
        }else{
            cell.likeButton.tintColor = .blue
        }
        return cell
    }
    
    func onClickLikeButton(cell : AllQuoteTableViewCell){
        
        allQuoteViewModel.onClickLike(cell: cell)
        
        if allQuoteViewModel.showedData[cell.tag].isLike == 1 {
            allQuoteViewModel.showedData[cell.tag].isLike = 0
            cell.likeButton.tintColor = .blue
        }else{
            allQuoteViewModel.showedData[cell.tag].isLike = 1
            cell.likeButton.tintColor = .red
        }
        
        reloadTableView()
    }
}
