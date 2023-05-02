import Foundation
import UIKit

class SupportCell : UITableViewCell {
    static let identifier = "SupportCell"
    
    lazy var label : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()

    }
    private func addView(){
        contentView.addSubview(label)
    
    }
    private func setAutoLayout(){
        
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            
        }
    }
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setAutoLayout()
    }


    //MARK: - required init?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(model : SupportModel){
        self.label.text = model.title
        
    }
}
