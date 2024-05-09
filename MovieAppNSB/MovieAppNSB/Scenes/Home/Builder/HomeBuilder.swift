//
//  HomeBuilder.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 7.05.2024.
//

import Foundation


final class HomeBuilder{
    static func make() -> HomeVC{
        let vm = HomeViewModel()
        let vc = HomeVC(viewModel: vm)
        return vc
    }
}
