//
//  SateliteProductCell.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 11.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

class SateliteProductCell: UITableViewCell {

    weak var containerView: UIView!
    weak var name: UILabel!
    weak var availability: UILabel!
    weak var productImage: UIImageView!
    weak var price: UILabel!
    
    
    var withBackView : Bool! {
        didSet {
            self.backViewGenerator()
        }
    }
    
    private var backView: UIImageView! // lazy
    
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
            make.top.leading.equalTo(8)
            make.trailing.bottom.equalTo(-8)
        }
        self.containerView = containerView
        
        
        let productImage = UIImageView()
        
        self.containerView.addSubview(productImage)
        productImage.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(4)
            make.trailing.equalTo(containerView.snp.trailing).inset(4)
            make.bottom.equalTo(containerView.snp.bottom).inset(4)
            make.width.equalTo(productImage.snp.height)
        }
        self.productImage = productImage
        
        
        let name = UILabel()
        name.textColor = UIColor.darkGray
        
        self.containerView.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.height.equalTo(32)
            make.trailing.equalTo(productImage.snp.leading).inset(8)
            
        }
        self.name = name
        
        
        let availability = UILabel()
        availability.textColor = UIColor.darkGray
        
        self.containerView.addSubview(availability)
        availability.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.height.equalTo(16)
            make.trailing.equalTo(productImage.snp.leading).inset(8)
        }
        self.availability = availability
        
        
        let price = UILabel()
        price.textColor = UIColor.darkGray
        
        self.containerView.addSubview(price)
        price.snp.makeConstraints { (make) in
            make.top.equalTo(availability.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.height.equalTo(24)
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
            make.trailing.equalTo(productImage.snp.leading).inset(8)
        }
        self.price = price
        
        
        
        
//        let backView = UIImageView(frame: productImage.frame)
        
//        self.backView = backView
        
        
        
    }
    
    func setup(_ name: String, price: String, availability: String) {
        
        self.name.text = name
        self.price.text = price
        self.availability.text = availability
        
        
    }
    
    func setupImage(_ image: UIImage) {
        
        self.productImage.image = image
        
        
    }
    
    
    
    private func backViewGenerator(){
//        backView.loadImage(fromURL: album.albumArtWork)
    }
    
//    override func prepareForReuse() {
//        productImage.image = UIImage()
//        backView.image = UIImage()
//    }
    
}
