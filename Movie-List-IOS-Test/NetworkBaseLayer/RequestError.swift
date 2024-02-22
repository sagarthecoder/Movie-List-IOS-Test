//
//  RequestError.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/22/24.
//

import UIKit

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatus
    case unknown
}
