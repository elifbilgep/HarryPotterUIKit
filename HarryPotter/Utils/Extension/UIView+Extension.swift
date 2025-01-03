//
//  UIView+Extension.swift
//  HarryPotter
//
//  Created by Elif Parlak on 29.12.2024.
//

import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
