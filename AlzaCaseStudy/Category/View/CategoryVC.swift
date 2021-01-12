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
    
    weak var tableView: UITableView!
    
    weak var label: UILabel!
    
    var imageLoader = ImageLoader()
    
    var categoryVM: CategoryViewModel
    
    var categoriesToRender: [Category] = []
    var sateliteProducts: [SateliteProduct] = []
    
    let disposeBag = DisposeBag()
    
    
    init(viewModel: CategoryViewModel) {
        
        self.categoryVM = viewModel
    
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if categoryVM.navigationStack.count > 1 && categoryVM.allowRemoval {
            self.categoryVM.navigationStack.removeLast()
        }
        
        if let desiredUrl = categoryVM.navigationStack.last {
            print("desiredUrl from navigationStack: \(String(describing: desiredUrl))")
            categoryVM.allowRemoval = true
            self.categoryVM.requestSatelite(url: desiredUrl)
        }
//        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBindings()
        
        
    }
    
    
    override func loadView() {
        super.loadView()
        
        navigationController?.navigationBar.barTintColor = .alzaBlueBackground
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .alzaLightGrayBackground
        
        let label = UILabel()
        label.text = "Hello world"
        label.textColor = .black
        
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            
        }
        
        self.label = label
        
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.backgroundColor = .alzaLightGrayBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        self.tableView = tableView
    }
    
    private func setupBindings() {
        
        categoryVM
            .sateliteModel
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (result) in
                
                self.sateliteProducts.removeAll()
                
                result.forEach { (sateliteObj) in

                    if let categoriesArray = sateliteObj.categories?.categoriesValue?.compactMap({ $0 }) {
                        let desiredCategories = categoriesArray.filter { (category) in
                            category.categorySelf?.appLink == "catalogLocalTitlePage"
                        }
                        self.categoriesToRender = desiredCategories
                    }
                    
                    if let productsArray = sateliteObj.products?.productsValue?.compactMap({ $0 }) {
                        let desiredProducts = productsArray.filter { (product) in
                            sateliteObj.itemType == "products"
                        }
                        print("desiredProducts count: \(desiredProducts.count)")
                        self.sateliteProducts.append(contentsOf: desiredProducts)
                    }

                }
                
                print("categoriesToRender count: \(String(describing: self.categoriesToRender.count))")
                print("sateliteProducts count: \(String(describing: self.sateliteProducts.count))")
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
    
}


