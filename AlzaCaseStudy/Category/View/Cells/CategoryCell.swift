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
    
    weak var containerView: UIView!
    weak var label: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .lightGray
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
            make.bottom.equalTo(0)
        }
        self.containerView = containerView
        
        let label = UILabel()
        label.textColor = UIColor.darkGray
        
        self.containerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            
            make.top.equalTo(17)
            make.bottom.equalTo(-17)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            
        }
        
        self.label = label
        
        
    }
    
    func setup(_ text:String) {
        
        self.label.text = text
        
        
    }
    
}
