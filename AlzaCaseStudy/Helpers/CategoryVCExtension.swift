//
//  CategoryVCExtension.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 12.01.2021.
//

import UIKit


extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.categoriesToRender.count
        } else if section == 2 {
            return self.sateliteProducts.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell: CategoryCell = tableView.dequeCellForIndexPath(indexPath)
            cell.selectionStyle = .none
            
            if let text: String = self.categoriesToRender[indexPath.row].name {
                cell.setup(text)
            }
            
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell: SateliteProductCell = tableView.dequeCellForIndexPath(indexPath)
            cell.selectionStyle = .none
            
            if let imagePath = self.sateliteProducts[indexPath.row].imgUrl {
                imageLoader.obtainImageWithPath(imagePath: imagePath) { (image) in
                    cell.setupImage(image)
                }
            }
            
            if let name: String = self.sateliteProducts[indexPath.row].name,
               let price = self.sateliteProducts[indexPath.row].price,
               let availability = self.sateliteProducts[indexPath.row].availability {
                
                cell.setup(name, price: price, availability: availability)
            }
            
            return cell
            
        } else {
            
            let cell: EmptyCell = tableView.dequeCellForIndexPath(indexPath)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            self.pushToNewCategory(indexPath: indexPath)
        } else if indexPath.section == 2 {
            self.pushToProductDetail(indexPath: indexPath)
        }
    }
    
    func pushToNewCategory(indexPath: IndexPath) {
        
        if let newCategoryUrl = self.categoriesToRender[indexPath.row].categorySelf?.categoryUrl {
            
            self.categoryVM.navigationStack.append(newCategoryUrl)
            let vc = CategoryVC(viewModel: self.categoryVM)
            categoryVM.allowRemoval = false
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func pushToProductDetail(indexPath: IndexPath) {
        
        let vc = ProductDetailVC()
        
        if let url = self.sateliteProducts[indexPath.row].productSelf?.productUrl {
            
            vc.productDetailUrl = url
            
        }
        
        categoryVM.allowRemoval = false
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
