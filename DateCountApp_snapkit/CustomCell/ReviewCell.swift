//
//  ReviewCell.swift
//  DateCountApp_snapkit
//
//  Created by Hyeonho on 2023/05/01.
//

import UIKit
protocol ReviewCellDelegate : AnyObject{
    func onClickCell(cell:ReviewCell)
}

class ReviewCell: UITableViewCell {
    static let identifier = "ReviewCell"
    var cellDelegate : ReviewCellDelegate?
    
    lazy var label : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    lazy var iconImage : UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()

    }
    private func addView(){
        contentView.addSubview(label)
        contentView.addSubview(iconImage)
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
    @objc func onClickCell() {
        cellDelegate?.onClickCell(cell: self)
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
    
    func bind(model : ReviewModel){
        self.label.text = model.title
        self.iconImage.image = model.iconImage!
    }
    
}
