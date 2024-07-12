//
//  Data+Extensions.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 12/07/2024.
//

import Foundation

extension Data {
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func decoded<T: Decodable>() throws -> T? {
        do {
            return try decoder.decode(T.self, from: self)
        } catch let DecodingError.typeMismatch(type, context)  {
            throw DecodingError.typeMismatch(type, context)
        } catch let error {
            throw error
        }
    }
}
