import SnapKit
import Foundation

class AllQuoteVC : UIViewController , UITabBarDelegate, UITableViewDataSource {
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
    }
    
    private func addView(){
        view.addSubview(quoteTableView)
    }
}
