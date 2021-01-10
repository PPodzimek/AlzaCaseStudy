//
//  CategoryVC.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 19.12.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class CategoryVC: UIViewController {
    
    var label: UILabel!
    
    var categoryVM = CategoryViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadView()
        self.setupBindings()
        categoryVM.requestHomePage()
    }
    
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Hello world"
        label.textColor = .black
        
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            
        }
        
        self.label = label
        
        
    }
    
    private func setupBindings() {
        
        categoryVM
            .homePageModel
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (result) in
                
                if let desiredObj = result.first(where: { (homePageObj) -> Bool in
                    return homePageObj.name == "Alza" || homePageObj.name == "Electronics"
                }) {
                    let desiredUrl = desiredObj.section.homePageSelf.sectionUrl.description
                    print("desiredUrl: \(String(describing: desiredUrl))")
                    self.categoryVM.requestSatelite(url: desiredUrl)
                } else {
                    print("Error getting desired satelite object")
                }
            })
            .disposed(by: disposeBag)
        
        
        categoryVM
            .sateliteModel
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (result) in
                
//                print("\n---\nCategoryVC sateliteModel result:\n---\n\(result)")
                
                result.forEach { (sateliteObj) in
                    
                    print("---")
                    print("itemType: \(String(describing: sateliteObj.itemType))")
                    print("title: \(String(describing: sateliteObj.title))")
                    print("---\n")

                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
}
