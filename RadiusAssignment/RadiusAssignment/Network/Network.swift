//
//  Network.swift
//  RadiusAssignment
//
//  Created by Ashok Rawat on 29/06/23.
//

import Foundation

// MARK: - Network Error

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

// MARK: - Request type

public enum HTTPMethod: String {
    case GET
    
    var method: String { rawValue.uppercased() }
}
