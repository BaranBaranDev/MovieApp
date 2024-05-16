//
//  UpcomingBuilder.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 9.05.2024.
//

import Foundation


final class UpcomingBuilder{
    static func make() ->  UpcomingVC {
        let vm = UpcomingViewModel()
        let vc =  UpcomingVC(viewModel: vm)
        return vc
    }
}
