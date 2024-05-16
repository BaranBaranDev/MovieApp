//
//  DownloadBuilder.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 16.05.2024.
//

import Foundation


final class DownloadBuilder{
    static func make() -> DownloadsVC {
        let vm = DownloadViewModel()
        let vc = DownloadsVC(viewModel: vm)
        return vc
    }
}
