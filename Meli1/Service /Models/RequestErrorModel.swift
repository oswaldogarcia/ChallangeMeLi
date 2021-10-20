//
//  RequestErrorModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 17/10/21.
//

import Foundation

// MARK: - RequestErrorModel
struct RequestErrorModel: Codable {
    var message, error: String?
    var status: Int?
}
