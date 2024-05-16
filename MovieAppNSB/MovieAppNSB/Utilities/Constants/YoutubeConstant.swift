//
//  YoutubeConstant.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 14.05.2024.
//

import Foundation


struct ConstantYoutube {
    static let API_KEY = "AIzaSyD-8WjPepnW-3DvHs2VnMzvcHLnWNU_3R0"
    static let baseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}



struct YoutubeURL {
    static func searchVideos(query: String) -> String? {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return "\(ConstantYoutube.baseURL)q=\(encodedQuery)&key=\(ConstantYoutube.API_KEY)"
    }
}
           



