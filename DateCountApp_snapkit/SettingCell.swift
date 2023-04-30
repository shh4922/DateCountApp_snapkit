import Foundation
import UIKit

class SettingCell : UITableViewCell {
    
    static let identifier = "SettingCell"
    
    lazy var label : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
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
}
