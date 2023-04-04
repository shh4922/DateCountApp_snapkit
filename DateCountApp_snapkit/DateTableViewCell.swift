
import SnapKit
import SwiftUI
import UIKit

class DateTableViewCell: UITableViewCell {
    
    static let identifier = "dateTableViewCell"
    
    lazy var vstack : UIStackView = {
        let vstack = UIStackView()
        vstack.distribution = .fillEqually
        vstack.axis = .vertical
        vstack.backgroundColor = .white
        return vstack
    }()
    
    lazy var top_hstack : UIStackView = {
        let hstack = UIStackView()
        hstack.distribution = .fillEqually
        hstack.axis = .horizontal
        return hstack
    }()
    lazy var bottom_hstack : UIStackView = {
        let hstack = UIStackView()
        hstack.distribution = .fillEqually
        hstack.axis = .horizontal
        return hstack
    }()
    lazy var testName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    lazy var testName_default: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    
    // 남은기간 D -
    lazy var dateCount_default: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    //날자
    lazy var dateCount: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private func addView(){
        contentView.addSubview(vstack)
        vstack.addArrangedSubview(top_hstack)
        vstack.addArrangedSubview(bottom_hstack)
        
        top_hstack.addArrangedSubview(testName_default)
        top_hstack.addArrangedSubview(testName)
        bottom_hstack.addArrangedSubview(dateCount_default)
        bottom_hstack.addArrangedSubview(dateCount)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
    private func setLayout(){
        vstack.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        top_hstack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        bottom_hstack.snp.makeConstraints { make in
            make.top.equalTo(top_hstack.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        testName_default.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        testName.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dateCount_default.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dateCount.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        testName_default.text = model.testName_default
        testName.text = model.testName
        dateCount_default.text = model.dateCount_default
        dateCount.text = "\(model.dateCount)"
    }
}
