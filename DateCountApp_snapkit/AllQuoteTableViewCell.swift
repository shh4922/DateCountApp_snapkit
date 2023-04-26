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
        contentView.layer.cornerRadius = 10
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
        contentView.backgroundColor = .systemYellow
        contentView.addSubview(quoteLabel)
        contentView.addSubview(authorLabel)
    }
    private func setAutoLayout(){
        quoteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.greaterThanOrEqualTo(contentView.snp.leading).offset(30)
            make.trailing.greaterThanOrEqualTo(contentView.snp.trailing).offset(-30)
        }
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(30)
            make.leading.greaterThanOrEqualTo(contentView.snp.leading).offset(50)
            make.trailing.greaterThanOrEqualTo(contentView.snp.trailing).offset(-50)
        }
    }
}


extension AllQuoteTableViewCell {
    public func bind(model: Quote) {
        quoteLabel.text = model.quote
        authorLabel.text = model.author
        
    }
}
