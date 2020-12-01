//
//  Encodable+Utility.swift
//
//  Created by Vivek Patel on 12/01/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options:[]) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
