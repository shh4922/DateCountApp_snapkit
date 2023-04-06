
import SnapKit
import SwiftUI
import UIKit

class DateTableViewCell: UITableViewCell {
    
    static let identifier = "dateTableViewCell"
    
    lazy var vstack : UIStackView = {
        let vstack = UIStackView()
        vstack.distribution = .fillEqually
        vstack.axis = .vertical
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
    lazy var dateCount_default: UILabel = {
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
    
    //MARK: addView
    private func addView(){
        contentView.addSubview(vstack)
        vstack.addArrangedSubview(top_hstack)
        vstack.addArrangedSubview(bottom_hstack)
        top_hstack.addArrangedSubview(testName)
        bottom_hstack.addArrangedSubview(dateCount_default)
        bottom_hstack.addArrangedSubview(dateCount)
        
    }
    
    //MARK: selectedCell
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
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        top_hstack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        bottom_hstack.snp.makeConstraints { make in
            make.top.equalTo(top_hstack.snp.bottom)
            make.left.equalToSuperview()
        }

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
        dateCount_default.text = model.dateCount_default
        dateCount.text = "\(model.dateCount)"
    }
}
