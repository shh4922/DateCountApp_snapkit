
import UIKit

class DateTableViewCell: UITableViewCell {
    
    static let identifier = "dateTableViewCell"
    
    lazy var vstack : UIStackView = {
        let vstack = UIStackView()
        vstack.distribution = .fillEqually
        vstack.axis = .vertical
        return vstack
    }()
    
    lazy var hstack : UIStackView = {
        let hstack = UIStackView()
        hstack.distribution = .fillEqually
        hstack.axis = .horizontal
        return hstack
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var testName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var defaultText: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    lazy var dateCount: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private func addView(){
        contentView.addSubview(vstack)
        vstack.addArrangedSubview(testName)
        vstack.addArrangedSubview(hstack)
        hstack.addArrangedSubview(defaultText)
        hstack.addArrangedSubview(dateCount)
        
    }
    private func setLayout(){
        vstack.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        hstack.snp.makeConstraints { make in
            make.top.equalTo(testName.snp.bottom)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DateTableViewCell {
    public func bind(model: DateModel) {
        
        testName.text = model.testName
        defaultText.text = model.defaultText
        dateCount.text = model.dateCount
    }
}
