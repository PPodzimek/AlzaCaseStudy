//
//  SateliteVC.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 11.01.2021.
//

import SnapKit
import RxSwift
import RxCocoa

class SateliteVC: UIViewController {
    
    var categoryVM = CategoryViewModel()
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBindings()
        categoryVM.requestHomePage()
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
                    self.categoryVM.navigationStack.append(desiredUrl)
                    self.categoryVM.allowRemoval = false
                    
                    let vc = CategoryVC(viewModel: self.categoryVM)
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: false, completion: nil)
                    
//                    self.categoryVM.requestSatelite(url: desiredUrl)
                } else {
                    print("Error getting desired satelite object")
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
