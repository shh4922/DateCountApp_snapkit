import Foundation
import UIKit

protocol SettingCellDelegate : AnyObject {
    
    func onClickCell(cell: SettingCell)
}

class SettingCell : UITableViewCell {
    
    static let identifier = "SettingCell"
    var cellDelegate : SettingCellDelegate?
    
    lazy var iconImage : UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    lazy var label : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()

    }
    private func addView(){
        contentView.addSubview(iconImage)
        contentView.addSubview(label)
    }
    @objc func onClickCell() {
        cellDelegate?.onClickCell(cell: self)
     }
    private func setAutoLayout(){
        iconImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualTo(contentView.snp.top).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(iconImage.snp.left).offset(-20)
            
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
    
    func bind(model : SettingModel){
        self.label.text = model.titleText
        self.iconImage.image = model.iconImage!
    }
}
