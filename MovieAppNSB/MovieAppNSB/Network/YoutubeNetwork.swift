//
//  YoutubeNetwork.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 14.05.2024.
//

import Foundation



// MARK: - YoutubeNetworkProtocol
protocol YoutubeNetworkProtocol {
    func getMovie(with query: String, completion: @escaping (Result<YoutubeSearchResponse, NetworkError>) -> Void)
}

// MARK: - YoutubeNetwork Class

final class YoutubeNetwork{
    static let shared = YoutubeNetwork()
    private init() {}
    
}


extension YoutubeNetwork: YoutubeNetworkProtocol {
    func getMovie(with query: String, completion: @escaping (Result<YoutubeSearchResponse, NetworkError>) -> Void) {
        NetworkManager.shared.fetchData(url: YoutubeURL.searchVideos(query: query)!, completion: completion)
    }
}
