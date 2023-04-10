
import SnapKit
import SwiftUI
import UIKit

class DateTableViewCell: UITableViewCell {
    
    static let identifier = "dateTableViewCell"
    
    lazy var vstack : UIStackView = {
        let vstack = UIStackView()
        vstack.distribution = .fillEqually
        vstack.spacing = 5
        vstack.axis = .vertical
        vstack.backgroundColor = .systemBackground
        vstack.setContentHuggingPriority(.init(251), for: .horizontal)
        vstack.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        vstack.spacing = 0
        //하위뷰들한테는 적용이 안된다함..
        vstack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
        vstack.isLayoutMarginsRelativeArrangement = true
        return vstack
    }()
    lazy var testName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 25)
        label.backgroundColor = .systemBackground
        label.layoutMargins = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 0)
        return label
    }()
    lazy var selectedDate: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0)
        return label
    }()
    lazy var dateCount_default: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .systemBackground
        label.setContentHuggingPriority(.init(252), for: .horizontal)
        label.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        return label
    }()
    lazy var dateCount: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.setContentHuggingPriority(.init(251), for: .horizontal)
        label.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        return label
    }()
    
    //MARK: addView
    private func addView(){
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(vstack)
        vstack.addArrangedSubview(testName)
        vstack.addArrangedSubview(selectedDate)
        contentView.addSubview(dateCount_default)
        contentView.addSubview(dateCount)
    }
    
//    MARK: selectedCell
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.gray.cgColor
        } else {
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        }
    }
    
    //MARK: setAutoLayout
    private func setAutoLayout(){
        
        vstack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(180)
        }
//        testName.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(15)
//            make.left.equalToSuperview().offset(10)
//        }
//        selectedDate.snp.makeConstraints { make in
//            make.top.equalTo(testName.snp.bottom).offset(0)
//            make.left.equalToSuperview().offset(10)
//        }
        
        dateCount_default.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(vstack.snp.right)
        }
        dateCount.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalTo(dateCount_default.snp.right)
        }
    }
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
        //셀 cornerRadius 적용.
        contentView.layer.masksToBounds = true
    }
    
    //MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        //tableviewCell을 상속받은 아이가 init을 수행하기위해선,
        //수퍼클래스의 init을 반드시 호출해주어야함.
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setAutoLayout()
    }
    /*
     required init? 은 필수생성자, 부모클래스에 "required init" 이게있다면 상속받은 아이들은 무조건적으로 required init?을  작성해주어야함.
     그런데 똑같이 작성하면 override를 작성해주어야하는데, 이녀석은 따로 작성해줄필요가없음.
     이녀석 자체로 override 되는거같음.
     하지만 잘 이해가가지않음.. 받아드려지지도 않고
     개념다시봐야할듯.
     
     *** 이부분이 문법책 12장이랑 18장에서 나오게되는데 아직은 모르는게 맞으니 그냥 그러려니하고 넘어가자 ***
     
     */
    //MARK: required init?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension DateTableViewCell {
    public func bind(model: DateModel) {
        testName.text = model.testName
        selectedDate.text = model.selectedDate
        dateCount_default.text = model.dateCount_default
        dateCount.text = "\(model.dateCount)"
    }
}
