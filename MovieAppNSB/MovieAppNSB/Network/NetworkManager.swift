//
//  NetworkManager.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 4.05.2024.
//

import Foundation
// imleci birden faza seçmek için shift yön tuşu alt satıea gelmek ise control toplu ekleme silme yapabilirsin



// MARK: - NetworkFetching Protocol

protocol NetworkFetching {
    func fetchData<T: Codable>(url urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

// MARK: - NetworkManager Class

final class NetworkManager {
    // Singleton Design Pattern
    static let shared = NetworkManager()
    private init() {}
    
}

extension NetworkManager: NetworkFetching{
    func fetchData<T: Codable>(url urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        Task { [weak self] in
            guard self != nil else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.noData))
            }
        }
    }
}
