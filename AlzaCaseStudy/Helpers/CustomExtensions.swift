//
//  CustomExtensions.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 12.01.2021.
//

import UIKit


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

extension UIColor {
    
    convenience init(hex: Int) {
            let components = (
                R: CGFloat((hex >> 16) & 0xff) / 255,
                G: CGFloat((hex >> 08) & 0xff) / 255,
                B: CGFloat((hex >> 00) & 0xff) / 255
            )
            self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
        }

    class var alzaBlueBackground: UIColor {
        return UIColor(hex: 0x1653a4)
    }


    class var alzaBlueText: UIColor {
        return UIColor(hex: 0x0094e7)
    }

    class var alzaLightGrayBackground: UIColor {
        return UIColor(hex: 0xf2f3f3)
    }
    
    class var alzaGreen: UIColor {
        return UIColor(hex: 0x398000)
    }
    
    class var alzaRed: UIColor {
        return UIColor(hex: 0xf00000)
    }
}
