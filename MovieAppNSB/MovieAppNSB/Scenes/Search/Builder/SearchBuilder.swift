//
//  SearchBuilder.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 9.05.2024.
//

import Foundation


final class SearchBuilder{
    static func make() ->  SearchVC {
        let vm = SearchViewModel()
        let vc =  SearchVC(viewModel: vm)
        return vc
    }
}
