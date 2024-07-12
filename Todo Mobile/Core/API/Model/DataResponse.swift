//
//  DataResponse.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 12/07/2024.
//

import Foundation

struct DataResponse<T: Codable>: Codable {
    let totalPage: Int
    let totalRecords: Int
    let dataList: [T]
}
