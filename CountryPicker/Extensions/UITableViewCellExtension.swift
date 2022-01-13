//
//  UITableViewCellExtension.swift
//  CountryPicker
//
//  Created by Jessel Esquinas on 1/13/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    /// Returns the nib name based on the class name as a `String`.
    open class func nibName() -> String {
        return String(describing: self)
    }
    
    /// Returns the nib based on the values returned by `UICollectionViewCell.nibName()` and `Bundle.bundle(forFileName:)`
    open class func nib() -> UINib {
        return UINib(nibName: nibName(), bundle: Bundle.main)
    }
    
}
