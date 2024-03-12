//
//  Helper.swift
//  FlyGuy
//
//  Created by Kishor Koli on 05/03/24.
//

import UIKit

extension Bundle {
    
    func decodeData<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil)
        else {
            fatalError("Could not locate the \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url)
        else {
            fatalError("Could not locate the \(file) in bundle")
        }
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(T.self, from: data)
        else {
             fatalError("Could not locate the \(file) in bundle")
        }
        return result
    }
}
