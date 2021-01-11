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


class CategoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var tableView: UITableView!
    
    weak var label: UILabel!
    
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
        
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.lightGray
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        self.tableView = tableView
    }
    
    private func setupBindings() {
        
//        categoryVM
//            .homePageModel
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { (result) in
//                
//                if let desiredObj = result.first(where: { (homePageObj) -> Bool in
//                    return homePageObj.name == "Alza" || homePageObj.name == "Electronics"
//                }) {
//                    let desiredUrl = desiredObj.section.homePageSelf.sectionUrl.description
//                    print("desiredUrl: \(String(describing: desiredUrl))")
//                    self.categoryVM.requestSatelite(url: desiredUrl)
//                } else {
//                    print("Error getting desired satelite object")
//                }
//            })
//            .disposed(by: disposeBag)
        
        
        categoryVM
            .sateliteModel
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (result) in
                
                self.sateliteProducts.removeAll()
                
                result.forEach { (sateliteObj) in
                    
                    print("---")
                    print("itemType: \(String(describing: sateliteObj.itemType))")
                    print("title: \(String(describing: sateliteObj.title))")
                    print("---\n")

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

extension CategoryVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {

//        var number = 0
//        let array = self.sateliteObjArray.filter { (satelite) -> Bool in
//            satelite.itemType.description == "products"
//        }
//        number = array.count
//
//        print("numberToRender: \(number)")
//        return number
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.categoriesToRender.count
        } else if section == 1 {
            return self.sateliteProducts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: CategoryCell = tableView.dequeCellForIndexPath(indexPath)
            if let text: String = self.categoriesToRender[indexPath.row].name {
                cell.setup(text, andTopSeparatorLeadingOffset: 8)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell: CategoryCell = tableView.dequeCellForIndexPath(indexPath)
            if let text: String = self.sateliteProducts[indexPath.row].name {
                cell.setup(text, andTopSeparatorLeadingOffset: 8)
            }
            return cell
        } else {
            return tableView.dequeCellForIndexPath(indexPath) as CategoryCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt indexPath: \(indexPath)")
        if indexPath.section == 0 {
            self.pushToNewCategory(indexPath: indexPath)
        } else if indexPath.section == 1 {
            self.pushToProductDetail(indexPath: indexPath)
        }
    }
    
    func pushToNewCategory(indexPath: IndexPath) {
        print("pushToNewCategory")
        
        if let newCategoryUrl = self.categoriesToRender[indexPath.row].categorySelf?.categoryUrl {
            
            self.categoryVM.navigationStack.append(newCategoryUrl)
            let vc = CategoryVC(viewModel: self.categoryVM)
            categoryVM.allowRemoval = false
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func pushToProductDetail(indexPath: IndexPath) {
        print("pushToProductDetail")
    }
    
}

extension UITableViewCell {
    class var cellIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableView {
    func dequeCellForIndexPath<T>(_ indexPath: IndexPath) -> T where T : UITableViewCell {
        register(T.classForCoder(), forCellReuseIdentifier: T.cellIdentifier)
        return dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
}
