//
//  ProductDetailVC.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 12.01.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProductDetailVC: UIViewController {
    
    weak var productImage: UIImageView!
    weak var productName: UILabel!
    weak var productSpec: UILabel!
    weak var price: UILabel!
    weak var availability: UILabel!
    
    var CategoryVM = CategoryViewModel()
    var productDetailVM = ProductDetailViewModel()
    var productDetailUrl: String?
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let productDetailUrl = productDetailUrl {
            self.productDetailVM.requestProductDetail(url: productDetailUrl)
        }
        
        self.setupBindings()
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let productImage = UIImageView()
        
        view.addSubview(productImage)
        productImage.snp.makeConstraints { (make) in
            make.top.equalTo(32)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        self.productImage = productImage
        
        
        let productName = UILabel()
        productName.textColor = .alzaBlueText
        productName.textAlignment = .center
        
        view.addSubview(productName)
        productName.snp.makeConstraints { (make) in
            make.top.equalTo(productImage.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(8)
            make.trailing.equalTo(view.snp.trailing).inset(8)
        }
        self.productName = productName
        
        
        let availability = UILabel()
        availability.textColor = .alzaGreen

        view.addSubview(availability)
        availability.snp.makeConstraints { (make) in
            make.top.equalTo(productName.snp.bottom).offset(24)
            make.centerX.equalTo(view.snp.centerX)
        }
        self.availability = availability
        
        
        let price = UILabel()
        price.textColor = .alzaRed
        
        view.addSubview(price)
        price.snp.makeConstraints { (make) in
            make.top.equalTo(availability.snp.bottom).offset(24)
            make.centerX.equalTo(view.snp.centerX)
        }
        self.price = price
        
    }
    
    private func setupBindings() {
        
        productDetailVM
            .productDetailModel
            .asObservable()
            .map { $0.name }
            .bind(to: self.productName.rx.text)
            .disposed(by: disposeBag)
        
        productDetailVM
            .productDetailModel
            .asObservable()
            .map { $0.price }
            .bind(to: self.price.rx.text)
            .disposed(by: disposeBag)
        
        productDetailVM
            .productDetailModel
            .asObservable()
            .map { $0.avail }
            .bind(to: self.availability.rx.text)
            .disposed(by: disposeBag)
        
        
    }
    
    
    
}
