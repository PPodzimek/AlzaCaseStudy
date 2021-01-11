//
//  CategoryCell.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 11.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryCell: UITableViewCell {
    
    weak var label: UILabel!
    weak var topSeparator: UIView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topSeparator = UIView()
        topSeparator.backgroundColor = UIColor.gray
        self.contentView.addSubview(topSeparator)
        topSeparator.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.top.equalTo(0)
            make.leading.equalTo(20)
            make.trailing.equalTo(0)
        }
        
        self.topSeparator = topSeparator
        
        
        
        
        let label = UILabel()
        
        label.textColor = UIColor.darkGray
        
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            
            make.top.equalTo(17)
            make.bottom.equalTo(-17)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            
        }
        
        
        self.label = label
        
        
    }
    
    func setup(_ text:String, andTopSeparatorLeadingOffset offset:CGFloat) {
        
        self.topSeparator.snp.updateConstraints { (make) in
            make.leading.equalTo(offset)
        }
        self.label.text = text
        
        
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        additionsVStackView.isHidden = true
//        additionsVStackView.arrangedSubviews.forEach { [weak self] in self?.additionsVStackView.removeArrangedSubview($0); $0.removeFromSuperview() }
//        separatorView.isHidden = false
//    }
    
}
