//
//  EmptyCell.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 11.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

class EmptyCell: UITableViewCell {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .lightGray
        
        self.contentView.snp.makeConstraints { (make) in
            make.height.equalTo(32)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        
    }
    
}
