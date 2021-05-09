//
//  Encodable+Extension.swift
//  Erun
//
//  Created by Saad Qureshi on 09/05/2021.
//

import Foundation

extension Encodable {
    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        let data = try! encoder.encode(self)
        let object = try! JSONSerialization.jsonObject(with: data, options: [])
        guard let json = object as? [String: Any] else { return [:] }
        return json
    }
}
