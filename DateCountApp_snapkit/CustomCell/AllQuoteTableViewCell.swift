//
//  AllQuoteTableViewCell.swift
//  DateCountApp_snapkit
//
//  Created by Hyeonho on 2023/04/27.
//

import UIKit

protocol allQuoteCellDelegate: AnyObject {
    // 위임해줄 기능
    func onClickLikeButton(cell : AllQuoteTableViewCell)
}

class AllQuoteTableViewCell: UITableViewCell {
    static let identifier = "allQuoteTableViewCell"
    
    var cellDelegate: allQuoteCellDelegate?
    
    lazy var quoteLabel : UILabel = {
        let quoteLabel = UILabel()
        quoteLabel.textColor = .black
        quoteLabel.textAlignment = .center
        quoteLabel.numberOfLines = 0
        quoteLabel.font = .boldSystemFont(ofSize: 17)
//        quoteLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 17)
        return quoteLabel
    }()
    lazy var authorLabel : UILabel = {
        let authorLabel = UILabel()
        authorLabel.textColor = .black
        authorLabel.textAlignment = .center
        authorLabel.numberOfLines = 0
        return authorLabel
    }()
    lazy var likeButton : UIButton = {
        let icon = UIImage(systemName: "heart")
        let subscriveButton = UIButton()
        subscriveButton.layer.cornerRadius = 10
        subscriveButton.backgroundColor = .white
        subscriveButton.setImage(icon, for: .normal)
        
        return subscriveButton
    }()
    @objc func onClickLike() {
        cellDelegate?.onClickLikeButton(cell: self)
     }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.likeButton.addTarget(self, action: #selector(onClickLike), for: .touchUpInside)
        addView()
        setAutoLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func addView(){
        contentView.addSubview(likeButton)
        contentView.addSubview(quoteLabel)
        contentView.addSubview(authorLabel)
        
    }
    private func setAutoLayout(){
        likeButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(contentView.snp.top).offset(1)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(likeButton.snp.trailing).offset(3)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
        }
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(5)
            make.leading.equalTo(likeButton.snp.trailing).offset(3)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            
            
        }
    }
    
    
}


extension AllQuoteTableViewCell {
    public func bind(model: ShowedQuote) {
        quoteLabel.text = model.quote
        authorLabel.text =  "- " + model.author! + " -"
    }
    
    
}
