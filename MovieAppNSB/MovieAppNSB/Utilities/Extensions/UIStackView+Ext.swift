//
//  UIStackView+Ext.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 9.05.2024.
//

import UIKit

extension UIStackView{
    func addArrangedSubviewFromExt(views: UIView...){
        views.forEach { [weak self] view in
            guard let self = self else{return}
            addArrangedSubview(view)
        }
    }
}

