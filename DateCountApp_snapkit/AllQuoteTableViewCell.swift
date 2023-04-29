//
//  AllQuoteTableViewCell.swift
//  DateCountApp_snapkit
//
//  Created by Hyeonho on 2023/04/27.
//

import UIKit

class AllQuoteTableViewCell: UITableViewCell {
    static let identifier = "allQuoteTableViewCell"
 
    
    lazy var quoteLabel : UILabel = {
        let quoteLabel = UILabel()
        quoteLabel.textColor = .black
        quoteLabel.textAlignment = .center
        quoteLabel.numberOfLines = 0
        quoteLabel.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 20)
        return quoteLabel
    }()
    lazy var authorLabel : UILabel = {
        let authorLabel = UILabel()
        authorLabel.textColor = .black
        authorLabel.textAlignment = .center
        authorLabel.numberOfLines = 0
        return authorLabel
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.layer.cornerRadius = 10
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        contentView.layer.masksToBounds = true
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setAutoLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func addView(){
//        contentView.backgroundColor = .lightGray
        contentView.addSubview(quoteLabel)
        contentView.addSubview(authorLabel)
        
//        view.addSubview(quoteLabel)
//        view.addSubview(authorLabel)
        
    }
    private func setAutoLayout(){
        
        quoteLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.greaterThanOrEqualTo(contentView.snp.leading).offset(10)

        }
        authorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(quoteLabel.snp.bottom).offset(5)
            make.leading.greaterThanOrEqualTo(contentView.snp.leading).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            
        }
    }
}


extension AllQuoteTableViewCell {
    public func bind(model: Quote) {
        quoteLabel.text = model.quote
        authorLabel.text =  "- " + model.author! + " -"
        
    }
}
