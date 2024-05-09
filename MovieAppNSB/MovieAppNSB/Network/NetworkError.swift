//
//  NetworkError.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 4.05.2024.
//

import Foundation

enum NetworkError: Error {
    case unableToComplete
    case invalidResponse
    case invalidURL
    case noData
    case invalidData
    case authenticationError
    case unknownError
    case decodingError(reason: String)
}
